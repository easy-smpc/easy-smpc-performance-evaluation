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

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.math3.stat.descriptive.moment.Mean;

import de.tu_darmstadt.cbs.emailsmpc.Study;

/**
 * Calculates time differences and logs them 
 * 
 * @author Felix Wirth
 * @author Fabian Prasser
 */
public class PerformanceRecorder {

    /** Measurements */
    private final Map<Integer, Long> start  = new HashMap<>();

    /** Measurements */
    private final Map<Integer, Long> end    = new HashMap<>();

    /** Model */
    private Study                    model;

    /**
     * Creates a new instance
     * 
     * @param model
     */
    public PerformanceRecorder(Study model) {
        this.model = model;
    }

    /**
     * Add finished time for a participant and calculates final results if all values are finished 
     * 
     * @param participantId
     * @param time
     */
    public synchronized void addFinishedTime(int participantId, long time) { 
        end.put(participantId, time);
    }
    
    /**
     * Records the start of a user's participation
     * 
     * @param participantId
     * @param time
     */
    public synchronized void addStartTime(int participantId, long time) {
        start.put(participantId, time);
    }
    
    /**
     * Measurement
     * @return
     */
    public synchronized long getFastest() {
        if (!isDone()) {
            throw new IllegalStateException("Experiment not done, yet");
        }
        return (long)getSortedDurations()[0];
    }

    /**
     * Measurement
     * @return
     */
    public synchronized double getMean() {
        if (!isDone()) {
            throw new IllegalStateException("Experiment not done, yet");
        }
        return new Mean().evaluate(getSortedDurations());
    }

    /**
     * Measurement
     * @return
     */
    public synchronized long getSlowest() {
        if (!isDone()) {
            throw new IllegalStateException("Experiment not done, yet");
        }
        return (long) getSortedDurations()[model.getNumParticipants() - 1];
    }
    
    /**
     * Returns whether all measurements have been obtained
     */
    public synchronized boolean isDone() {
        return start.size() == model.getNumParticipants() && end.size() == model.getNumParticipants();
    }
    
    /**
     * Returns a sorted list of all execution times
     * @return
     */
    private double[] getSortedDurations() {

        // Calculate execution times
        double[] times = new double[start.size()];
        int index = 0;
        for (int participant : start.keySet()) {
            times[index++] = end.get(participant) - start.get(participant);
        }
        
        // Sort
        Arrays.sort(times);
        
        // Done
        return times;
    }
}
