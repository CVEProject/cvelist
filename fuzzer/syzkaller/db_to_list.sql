WITH `base` AS (
  SELECT
    DISTINCT
    `syzkaller`,
    (
        SELECT
          `commit`
        FROM
          `tags`
        WHERE
          `commit` = `fixed_by`
    ) `fixed_by`,
    (
        SELECT
          `upstream`
        FROM
          `upstream`
        WHERE
          `commit` = `fixed_by`
        UNION ALL
        SELECT
          `commit`
        FROM
          `tags`
        WHERE
          `commit` = `fixed_by`
          AND LENGTH(REPLACE(`tags`, ".", "")) = LENGTH(`tags`) - 1
    ) `fixed_by_upstream`,
    IIF(
      LENGTH(`introduced_by_short`)<4,
      null,
      (
        SELECT
          `commit`
        FROM
          `tags`
        WHERE
          `commit` >= `introduced_by_short`
          AND `commit` < `introduced_by_short`||"g"
      )
    ) `introduced_by`
  FROM
    (
      SELECT
        `syzkaller`,
        `fixed_by`,
        (
          SELECT
            SUBSTR(`fixes`, 0, INSTR(`fixes`, " "))
          FROM
            `fixes`
          WHERE
            `commit` = `fixed_by`
        ) `introduced_by_short`
      FROM
        (
          SELECT
            'extid=' || SUBSTRING(
              `reported_by`,
              INSTR(`reported_by`, "bot+") + LENGTH("bot+"),
              INSTR(`reported_by`, "@") - INSTR(`reported_by`, "bot+") - LENGTH("bot+")
            ) `syzkaller`,
            `commit` `fixed_by`
          FROM
            `reported_by`
          WHERE
            `reported_by`
          LIKE
            "%bot+%"
          UNION ALL
          SELECT
            'id=' || `syzkaller` `syzkaller`,
            `commit` `fixed_by`
          FROM
            `syzkaller`
        )
    )
  WHERE
    `introduced_by` is not null
  ),
`tagged` AS
  (
    SELECT
      `syzkaller`,
      `fixed_by_upstream`,
      `fixed_by`,
      (
        SELECT
          SUBSTR(`tags`, 1 + LENGTH('tags/'), MIN(INSTR(`tags`||'~', '~'), INSTR(`tags`||'-', '-')) - LENGTH('tags/') - 1)
        FROM
          `tags`
        WHERE
          `commit`=`fixed_by`
      ) `fixed_by_tag`,
      `introduced_by`,
      (
        SELECT
          SUBSTR(`tags`, 1 + LENGTH('tags/'), MIN(INSTR(`tags`||'~', '~'), INSTR(`tags`||'-', '-')) - LENGTH('tags/') - 1)
        FROM
          `tags`
        WHERE
          `commit`=`introduced_by`
      ) `introduced_by_tag`
    FROM
      `base`
  ),
`relevant` AS
  (
    SELECT
      `syzkaller`,
      `introduced_by`,
      `introduced_by_tag`,
      `fixed_by_upstream`,
      (SELECT GROUP_CONCAT(`commit`, ',') FROM `upstream` WHERE `upstream`=`fixed_by_upstream`) `fixed_by_downstream`,
      `fixed_by`,
      `fixed_by_tag`,
      (SELECT GROUP_CONCAT(`cve`, ',') FROM `cve` WHERE `commit`=`fixed_by`) `cve`
    FROM
      `tagged`
    WHERE
      `fixed_by_tag`<>`introduced_by_tag`
  )
SELECT * FROM `relevant`;