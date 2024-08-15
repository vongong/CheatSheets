# JQL - Jira Query Language
A simple query in JQL (also known as a “clause”) consists of a `field`, followed by an `operator`, followed by one or more `values` or `functions`. This is most commonly used by Filters.

For example: 
- `Project` = `Test`
- `Assignee` in `(currentUser())`

## Links
- [JQL Functions](https://support.atlassian.com/jira-software-cloud/docs/jql-functions/)
- [JQL Cheatsheet](https://atlassianblog.wpengine.com/wp-content/uploads/2017/01/atlassian_jql-cheat-sheet.pdf)

## Fields
- Assignee
- Affected version
- Attachments
- Comment
- Created
- Creator
- Description
- Due
- Priority
- Project
- Reporter
- Resolved
- Sprint
- Status
- Summary
- Text

## Operator
- `=`
- `<`
- `>`
- `in`
- `is`
- `not`

## Functions

### Time
- startOfDay/Week/Month/Year
- endOfDay/Week/Month/Year
- lastLogin()
- now()
  
### People
- currentLogin()
- currentUser()
- membersOf()

## Sort List
The results can be sorted with the keyword `Order By` followed by `field` and `direction`(Asc/Desc). 

Example: Order By created Desc
