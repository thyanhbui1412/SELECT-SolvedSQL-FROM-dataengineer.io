WITH summary AS (SELECT bc.bug_num,
                        b.title                                         AS bug_title,
                        bc.component_id,
                        c.title                                         AS component_title,
                        ROW_NUMBER() OVER (PARTITION BY bug_num)        AS component_count,
                        COUNT(bug_num) OVER (PARTITION BY component_id) AS bugs_in_component
                 FROM playground.bug_component bc
                          LEFT JOIN playground.bug b ON bc.bug_num = b.num
                          LEFT JOIN playground.component c ON bc.component_id = c.id)
SELECT bug_title, component_title, bugs_in_component
FROM summary
WHERE bug_num IN (SELECT bug_num FROM summary WHERE component_count = 2) --filter out bug affecting more than 2 components
ORDER BY bugs_in_component DESC, bug_title ASC
