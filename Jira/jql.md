# JQL - Jira Query Language
A simple query in JQL (also known as a “clause”) consists of a `field`, followed by an `operator`, followed by one or more `values` or `functions`. This is most commonly used by Filters. Use `logical operators` to combine jql clauses together (ie. and, or).

For example: 
- `Project` = `EWR`
- `Project` = `EWR` AND `createdDate` >= `'2024-01-01'`
- `Project` = `EWR` AND `createdDate` >= `startOfYear()`
- `Project` = `EWR` AND `Assignee` in `(currentUser())`
- project = EWR and createdDate >= startOfYear() AND assignee = currentUser() order by created asc
- createdDate >= '2024-01-01'

## Links
- [JQL Functions](https://support.atlassian.com/jira-software-cloud/docs/jql-functions/)
- [JQL Cheatsheet](https://atlassianblog.wpengine.com/wp-content/uploads/2017/01/atlassian_jql-cheat-sheet.pdf)
- [JQL Syntex](https://support.atlassian.com/jira-service-management-cloud/docs/use-advanced-search-with-jira-query-language-jql/)

## Jira Filters
- Export Issues
  - if over 1000 results, user Apps (Google Sheets or MS Excel)
- List v Detail Views
- Basic v Jql
- Save
  - Permissions
  - Subscriptions
- Bulk Change

## Fields
- Assignee
- Affected version
- Attachments
- Comment
- CustomField
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

### Date Format
- Ref Specific Date: YYYY-MM-DD. ie "2018-01-31"
- n Days: -30d
- Date Function: StartOfWeek()

## Operator
- `=`
- `!=`
- `<`
- `>`
- `<=`
- `>=`
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

## Logical Operator

- And
- Or

## Sort List
The results can be sorted with the keyword `Order By` followed by `field` and `direction`(Asc/Desc). 

Example: Order By created Desc
