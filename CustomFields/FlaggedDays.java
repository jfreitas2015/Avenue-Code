<!-- @@Formula:

import org.apache.commons.lang.StringUtils;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.atlassian.jira.component.ComponentAccessor;

public static double castRoundTo1(double d)
{
// Utility to round off to 1 decimal
return (long) (d * 10 + 0.5) / 10.0;
}

// Get the Change History for the field Flagged
items = ComponentAccessor.getChangeHistoryManager().getChangeItemsForField
(
issue.getIssueObject(), "Flagged"
);

// Setup some variables
flaggedCounter = 0; // The number of times the field has been set
Date date = new Date(); // Current Timestamp
long duration = 0; // This is the total duration the field was set
long startTime = 0; // Start Time for each episode
long stopTime; // Stop Time for each episode
String lastSetting; // Indicator for last history event

// Go through all history items for the Flagged field
for (item : items) {
if (item.getToString() != null && !item.getToString().isEmpty()) {
// The field was set. Start the clock!
startTime = item.getCreated().getTime();
// log.error("Set: " + item.getCreated().toString());
// log.error("Set Time: " + item.getCreated().getTime().toString());
lastSetting = "Set"; // Indicate last event!
continue; // Iterate next loop if the field was set
} else {
// The field was cleared. Stop the clock
stopTime = item.getCreated().getTime();

// log.error("Cleared: " + item.getCreated().toString());
// log.error("Cleared Time: " + item.getCreated().getTime().toString());
lastSetting = "Clear"; // Indicate last event!
}

// We have a Stop and Start time, calculate the dur and add it
long lastDuration = stopTime - startTime;
duration += lastDuration;
// log.error("This duration was: " + lastDuration);
}

// If the field is currently set. Take current time and add it to the duration
if(lastSetting.equals("Set")){
// Set stopTime to now
stopTime = date.getTime();
duration += (stopTime - startTime);
}
// log.error("Total Duration: " + duration );

// Convert to days and round off to 1 decimal
double days = castRoundTo1(duration / 1000.0 / 60.0 / 60.0 / 24.0);

// log.error("Workday Duration: " + days );

// Finally return the number of days
return days;

-->