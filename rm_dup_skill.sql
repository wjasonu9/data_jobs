CREATE TEMP TABLE sk_repl ( -- deleted when the session ends, Ctrl+D in terminal
    oldi INT PRIMARY KEY,
    newi INT NOT NULL
);
INSERT INTO sk_repl (oldi,newi)
VALUES (164,150), (166,150), (66,82), (27,8), (130,121), (18,62), (24,62),
    (154,145), (28,2), (203,183), (205,183), (147,110), (153,144),
    (165,144), (186,7), (71,61), (72,61), (54,21), (140,138);
COPY sk_repl TO '/tmp/sk_repl.csv' DELIMITER ',' CSV HEADER;

-- 1st remove old IDs where the replacement already exists.
DELETE FROM skills_job_dim AS sjd
USING sk_repl
WHERE sjd.skill_id = sk_repl.oldi
  AND sk_repl.newi in (SELECT skill_id
    FROM skills_job_dim AS sjd2
    WHERE sjd.job_id = sjd2.job_id);
/*EXISTS (
      SELECT 1
      FROM skills_job_dim sjd2
      WHERE sjd2.job_id = sjd.job_id
        AND sjd2.skill_id = sk_repl.newi
  )
This fails if multiple old IDs map to the same new ID due to the primary key constraints: 
UPDATE skills_job_dim AS sjd
SET skill_id = sk_repl.newi
FROM sk_repl
WHERE sjd.skill_id = sk_repl.oldi;
Instead, for every remaining old skill, insert its replacement.
DISTINCT keeps multiple old ids that map to the same replacement
from creating duplicate (job_id, skill_id) entries. */
INSERT INTO skills_job_dim (job_id, skill_id)
SELECT DISTINCT sjd.job_id, sk_repl.newi
FROM skills_job_dim AS sjd
INNER JOIN sk_repl
  ON sjd.skill_id = sk_repl.oldi;

-- Now remove the old IDs that were replaced.
DELETE FROM skills_job_dim AS sjd
USING sk_repl
WHERE sjd.skill_id = sk_repl.oldi;
COPY skills_job_dim TO '/tmp/skills_job_dim.csv' DELIMITER ',' CSV HEADER;
-- check constraint name with \d skills_job_dim
ALTER TABLE skills_job_dim
DROP CONSTRAINT skills_job_dim_skill_id_fkey;   
DELETE FROM skills_dim;
/* DROP TABLE skills_dim;
CREATE TABLE public.skills_dim
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);
ALTER TABLE public.skills_dim OWNER to postgres; */
COPY skills_dim
FROM '/tmp/skills_dim.csv'
-- FROM PROGRAM 'curl -L https://drive.usercontent.google.com/download?id=1wfVxoU_bkkj2lw6jNeIz-NGhv901OYN8&confirm=t'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
ALTER TABLE skills_job_dim
ADD CONSTRAINT skills_job_dim_skill_id_fkey
FOREIGN KEY (skill_id)
REFERENCES skills_dim(skill_id);
