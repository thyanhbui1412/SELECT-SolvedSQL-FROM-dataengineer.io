WITH dedupped AS (SELECT DISTINCT sender_id, receiver_id FROM playground.messenger),
     part1_bidirectional AS (SELECT d.sender_id   AS sender_id,
                                    d.receiver_id AS receiver_id,
                                    i.sender_id   AS isender_id,
                                    i.receiver_id AS ireceiver_id
                             FROM dedupped d
                                      JOIN (SELECT receiver_id AS sender_id, sender_id AS receiver_id FROM dedupped) i
                                           ON d.sender_id = i.sender_id AND d.receiver_id = i.receiver_id),
     count_part1 AS (SELECT COUNT(*) / 2 AS count FROM part1_bidirectional),
     count_part2 AS (SELECT COUNT(*) AS count
                     FROM dedupped
                     WHERE (sender_id, receiver_id) NOT IN (SELECT sender_id, receiver_id FROM part1_bidirectional))
SELECT ((SELECT count FROM count_part1) + count) AS count
FROM count_part2
