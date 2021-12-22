package org.bihealth.mi.easysmpc.performanceevaluation;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;

/**
 * Interface to print results of a performance evaluation
 * 
 * @author Felix Wirth
 * @author Fabian Prasser
 */
public class PerformanceResultPrinter {

    /** CSV printer */
    private CSVPrinter printer;

    /**
     * Creates a new instance
     * 
     * @param file
     * @throws IOException
     */
    public PerformanceResultPrinter(String file) throws IOException {

        // Create CSV printer
        printer = new CSVPrinter(Files.newBufferedWriter(Paths.get(file),
                                                            StandardOpenOption.APPEND,
                                                            StandardOpenOption.CREATE),
                                    CSVFormat.DEFAULT.withHeader("Date",
                                                                 "StudyUID",
                                                                 "Number participants",
                                                                 "Number bins",
                                                                 "Mailbox check interval",
                                                                 "Fastest processing time",
                                                                 "Slowest processing time",
                                                                 "Mean processing time",
                                                                 "Number messages received",
                                                                 "Total size messages received",
                                                                 "Number messages sent",
                                                                 "Total size messages sent"));
    }

    public synchronized void close() throws IOException {
        printer.close();
    }
    
    /**
     * Print data
     * 
     * @param values
     * @throws IOException
     */
    public synchronized void print(Object... values) throws IOException {
        printer.printRecord(values);
        printer.flush();
    }
}
