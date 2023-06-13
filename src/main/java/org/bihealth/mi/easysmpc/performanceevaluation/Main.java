/* 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.bihealth.mi.easysmpc.performanceevaluation;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.bihealth.mi.easybus.Bus;
import org.bihealth.mi.easybus.BusException;
import org.bihealth.mi.easybus.MessageFilter;
import org.bihealth.mi.easybus.PasswordStore;
import org.bihealth.mi.easybus.implementations.http.easybackend.BusEasyBackend;
import org.bihealth.mi.easybus.implementations.http.easybackend.ConnectionSettingsEasyBackend;
import org.bihealth.mi.easysmpc.performanceevaluation.Combinator.Combination;

/**
 * EasySMPC performance evaluation
 * 
 * @author Felix Wirth
 * @author Fabian Prasser
 */
public class Main {
    
	/** File path */
	private static final String FILEPATH = "result.csv";
	
	/** Logger */
	private static final Logger LOGGER = LogManager.getLogger(Main.class);
	
	/**  Default message size */
    public static final int DEFAULT_MESSAGE_SIZE = 1024 * 1024;
	
	/**
	 * Starts the performance test
	 *
	 * @param args
	 * @throws IOException 
	 * @throws BusException 
	 */
	public static void main(String[] args) throws IOException, BusException {
	    
	    // Output start message
        System.out.println("Performance evaluation started");
        System.out.println("For results see /root/easy-smpc/"+ FILEPATH);
        
        PerformanceResultPrinter printer = new PerformanceResultPrinter(FILEPATH);
        
        // Repetitions
        int repetitionsPerCombination = 15;
        
		// Performance tracking
		PerformanceTracker tracker = new PerformanceTracker();
		
		
        // Create connection settings
        ConnectionSettingsEasyBackend connectionSettingsTemplate = new ConnectionSettingsEasyBackend("easy" + SettingsGenerator.INDEX_REPLACE + "@easysmpc.org", null)
                .setAPIServer(new URL("http://eb-service:8080"))
                .setAuthServer(new URL("http://eb-keycloak:8080"))
                .setMaxMessageSize(DEFAULT_MESSAGE_SIZE);
        connectionSettingsTemplate.setPasswordStore(new PasswordStore("12345"));

		// Create parameters
        List<Integer> participants = new ArrayList<>(Arrays.asList(new Integer[] { 20, 15, 10, 5, 3 }));
        List<Integer> bins = new ArrayList<>(Arrays.asList(new Integer[] { 10000, 7500, 5000, 2500, 1000 }));
        List<Integer> mailboxCheckInterval = new ArrayList<>(Arrays.asList(new Integer[] { 20000, 15000, 10000, 5000, 1000 }));
		
		// Create combinator
		Combinator combinator = new CombinatorRepeatPermute(participants, bins, mailboxCheckInterval, repetitionsPerCombination);

		// Create mailbox details
		SettingsGenerator settingsGenerator = new SettingsGenerator(connectionSettingsTemplate, participants, tracker);

        // Prepare mailbox
        try {

            // Delete existing messages relevant to EasySMPC
            Bus bus = new BusEasyBackend(1, 1000, settingsGenerator.getConnection(0), settingsGenerator.getSelf(0), Main.DEFAULT_MESSAGE_SIZE);
            bus.purge(new MessageFilter() {

                @Override
                public boolean accepts(String messageDescription) {
                    return true;
                }
            });
            bus.stop();

        } catch (BusException | InterruptedException e) {
            LOGGER.error("Preparation failed logged", new Date(), "Preparation failed", ExceptionUtils.getStackTrace(e));
            throw new IllegalStateException("Unable to prepare performance evaluation", e);
        }

        // Conduct an EasySMPC process over each combination
        for(Combination combination: combinator) {

            // Start an EasySMPC process
            UserCreating user = new UserCreating(combination.getParticipants(), 
                                                 combination.getBins(), 
                                                 combination.getMailboxCheckInterval(), 
                                                 settingsGenerator,
                                                 printer);

            // Wait to finish
            while (!user.areAllUsersFinished()) {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    LOGGER.error("Interrupted exception logged", new Date(), "Interrupted exception logged",
                                 ExceptionUtils.getStackTrace(e));
                }
            }

            // Reset statistics
            settingsGenerator.getTracker().resetStatistics();

            // Wait
            LOGGER.debug("Process finished logged", new Date(), "Process finished!");
        }
        
        // Close printer
        printer.close();
	}
}