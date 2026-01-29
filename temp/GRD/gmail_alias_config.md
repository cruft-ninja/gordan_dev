# Create Gmail Alias & Filter for "+dev" To or From Addresses


## Create Alias

Creating a +dev alias in Gmail does not require any special setup in the settings; it is an automatic feature known as plus addressing. 
Here is how to create and use it:

1. How to Create the Alias
Simply add +dev immediately after your username and before the @gmail.com in your email address. 
Example: If your email is username@gmail.com, your new alias is username+dev@gmail.com.

2. How to Use It
Sign-ups: Use username+dev@gmail.com when signing up for developer tools, newsletters, or websites.
Delivery: All emails sent to this address will arrive directly in your primary username@gmail.com inbox.
Filtering: To keep your inbox organized, you can create a Gmail Filter to automatically label or archive emails sent to this address. 

3. Key Benefits
Instant Creation: You do not need to register the alias; it works immediately.
Organization: You can set up filters to move all +dev mail to a specific folder, keeping your main inbox clean.



## Create Filter

To create a filter in Gmail for "+dev" addresses that bypasses the inbox and moves to a "Dev Workspace" label, follow these steps:

1. Define the Search Criteria
Open Gmail Settings: Click the Show search options icon (the slider icon) in the search bar.
Set Addresses: In the Has the words field, enter the following logic to capture "+dev" in either the sender or recipient fields: {(to:+dev) (from:+dev)}.
Note: Using the "Has the words" field with this bracketed logic ensures that if the string "+dev" appears in either the To or From headers, it will be caught.
Proceed: Click Create filter at the bottom of the search window. 

2. Configure Filter Actions
In the next window, select these specific actions:
Skip the Inbox (Archive it): This prevents the email from appearing in your main inbox.
Apply the label: Choose New label... from the dropdown and type Dev Workspace.
(Optional) Apply to existing: Check Also apply filter to matching conversations if you want to move existing "+dev" emails to this new label immediately.
Finalize: Click Create filter. 

3. Verify Your Filter
You can manage or edit this filter at any time by going to Settings > See all settings > Filters and Blocked Addresses. 
If emails still appear in your inbox after creation, ensure that Never mark as important is also checked in the filter settings, as Gmail's "Important" marker can sometimes override the "Skip the Inbox" command.