UPDATE dbo.LANGUAGES SET ENGLISH = REPLACE(ENGLISH,'Task','work'), ENGLISH_OR = REPLACE(ENGLISH,'Task','work')
FROM dbo.LANGUAGES WHERE	ENGLISH LIKE '%Task%'
