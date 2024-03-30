WITH start_time AS (SELECT session_id, session_time AS start
                    FROM playground.sessions
                    WHERE session_status = 'start'),
     stop_time AS (SELECT session_id, session_time AS stop
                   FROM playground.sessions
                   WHERE session_status = 'stop'),
     uptime AS (SELECT SUM(sto.stop - sta.start) AS total_uptime_days
                FROM start_time sta
                         JOIN stop_time sto USING (session_id))
SELECT EXTRACT(DAY FROM total_uptime_days) AS total_uptime_days
FROM uptime
