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

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.bihealth.mi.easybus.BusException;
import org.bihealth.mi.easybus.Participant;
import org.bihealth.mi.easybus.PasswordStore;
import org.bihealth.mi.easybus.implementations.http.easybackend.ConnectionSettingsEasyBackend;

/**
 * Stores the connections details
 * 
 * @author Felix Wirth
 * @author Fabian Prasser
 */
public class SettingsGenerator {

    /** Replace this by index */
    public static final String                  INDEX_REPLACE = "REPLACE";
    /** Template to create ConnectionIMAPSettings */
    private final ConnectionSettingsEasyBackend connectionTemplate;
    /** Max participants */
    private final Integer                       maxParticipants;
    /** Tracker */
    private transient PerformanceTracker tracker;

    /**
     * Creates a new instance
     * 
     * @param connectionTemplate
     * @param participants
     * @param tracker
     */
    public SettingsGenerator(ConnectionSettingsEasyBackend connectionTemplate, List<Integer> participants, PerformanceTracker tracker) {
        
        // Store       
        this.connectionTemplate = connectionTemplate;
        this.maxParticipants = Collections.max(participants);
        this.tracker = tracker;
    }
    
    
    /**
     * Get all distinct connections
     * 
     * @return
     */
    public List<ConnectionSettingsEasyBackend> getAllConnections() {
        // Init
        Set<ConnectionSettingsEasyBackend> connections = new HashSet<>();

        // Get all connections with no duplicates
        for (int index = 0; index < this.maxParticipants; index++) {
            connections.add(getConnection(index));
        }

        // Return
        return new ArrayList<>(connections);
    }
    
    /**
     * Gets the connection for participant with given index
     * 
     * @param index
     * @return
     */
    public ConnectionSettingsEasyBackend getConnection(int index) {
        
        // Return new connection
            return (ConnectionSettingsEasyBackend) new ConnectionSettingsEasyBackend(getSelf(index).getEmailAddress(), null)
                    .setAPIServer(connectionTemplate.getAPIServer())
                    .setAuthServer(connectionTemplate.getAuthServer())
                    .setListener(tracker)
                    .setMaxMessageSize(connectionTemplate.getMaxMessageSize())
                    .setPasswordStore(new PasswordStore(connectionTemplate.getPasswordStore().getFirstPassword()));
    }
    
    /**
     * Returns the self object for a given index
     * 
     * @param index
     * @return
     */
    public Participant getSelf(int index) {

        // Replace
        String email = connectionTemplate.getIdentifier()
                                           .replaceFirst(INDEX_REPLACE, String.valueOf(index));
        String  name = email.substring(0, email.indexOf("@"));

        try {
            return new Participant(name, email);
        } catch (BusException e) {
            throw new IllegalStateException("Particpants could not be created");
        }
    }
    
    /**
     * Returns the tracker
     * @return
     */
    public PerformanceTracker getTracker() {
    	return this.tracker;
    }
}