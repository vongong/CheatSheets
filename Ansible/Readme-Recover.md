
## Recover from error

**recover from errors w blocks**
- *block*: are logically unit
  - like install and configure yum
  - Things you want to attempt
- *rescue*: recover from failure
  - things you want to mitigate failure
- *always*: define task to always run
  - things you want run no matter the situation/cleanup
- can have **when** to add conditonal
```yaml
tasks:
  - name: upgrade db
    block:
      - name: upgrade the database
        shell:
          cmd: /usr/local/lib/upgrade-database
    rescue:
      - name: revert the database
        shell:
          cmd: /usr/local/lib/revert-database
    always:
      - name: restart database
        service:
          name: mariadb
          state: restarted
```