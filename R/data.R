#' Anonymized behavioral data for 942,816 students using the ASSISTments platform.
#'
#' This data is from a longitudinal study that tracks
#' students from their use of the ASSISTments blended learning platform
#' in middle school in 2004-2007, to their high school course-taking,
#' college enrollment, and first job out of college.
#'
#' @format A data frame with 942816 rows and 82 variables:
#' \describe{
#'   \item{ITEST_id}{a deidentified ID/tag used for identifying an individual student}
#'   \item{SY ASSISTments Usage}{the academic years the student used ASSISTments}
#'   \item{AveKnow}{average student knowledge level (according to Bayesian Knowledge Tracing algorithm -- cf. Corbett & Anderson, 1995)}
#'   \item{AveCarelessness}{average student carelessness (according to San Pedro, Baker, & Rodrigo, 2011 model)}
#'   \item{AveCorrect}{average student correctness}
#'   \item{NumActions}{total number of student actions in system}
#'   \item{AveResBored}{average student affect: boredom (see Pardos, Baker, San Pedro, Gowda, & Gowda, 2014)}
#'   \item{AveResEngcon}{average student affect:engaged concentration (see Pardos, Baker, San Pedro, Gowda, & Gowda, 2014)}
#'   \item{AveResConf}{average student affect:confusion (see Pardos, Baker, San Pedro, Gowda, & Gowda, 2014)}
#'   \item{AveResFrust}{average student affect:frustration (see Pardos, Baker, San Pedro, Gowda, & Gowda, 2014)}
#'   \item{AveResOfftask}{average student affect: off task (see Pardos, Baker, San Pedro, Gowda, & Gowda, 2014 and also Baker, 2007)}
#'   \item{AveResGaming}{average student affect:gaming the system (see Pardos, Baker, San Pedro, Gowda, & Gowda, 2014 and also Baker Corbett Koedinger & Wagner, 2004)}
#'   \item{actionId}{the unique id of this specific action}
#'   \item{skill}{a tag used for identifying the cognitive skill related to the problem (see Razzaq, Heffernan, Feng, & Pardos, 2007)}
#'   \item{problemId}{a unique ID used for identifying a single problem}
#'   \item{assignmentId}{a unique ID used for identifying an assignment}
#'   \item{assistmentId}{a unique ID used for identifying an assistment (a instance of a multi-part problem)}
#'   \item{startTime}{when did the student start the problem (UNIX time, seconds)}
#'   \item{endTime}{when did the student end the problem (UNIX time, seconds)}
#'   \item{timeTaken}{Time spent on the current step}
#'   \item{correct}{Answer is correct}
#'   \item{original}{Problem is original not a scaffolding problem}
#'   \item{hint}{Action is a hint response}
#'   \item{hintCount}{Total number of hints requested so far}
#'   \item{hintTotal}{total number of hints requested for the problem}
#'   \item{scaffold}{Problem is a scaffolding problem}
#'   \item{bottomHint}{Bottom-out hint is used}
#'   \item{attemptCount}{Total problems attempted in the tutor so far.}
#'   \item{problemType}{the type of the problem}
#'   \item{frIsHelpRequest}{First response is a help request}
#'   \item{frPast5HelpRequest}{Number of last 5 First responses that included a help request}
#'   \item{frPast8HelpRequest}{Number of last 8 First responses that included a help request}
#'   \item{stlHintUsed}{Second to last hint is used Ð indicates a hint that gives considerable detail but is not quite bottom-out}
#'   \item{past8BottomOut}{Number of last 8 problems that used the bottom-out hint.}
#'   \item{totalFrPercentPastWrong}{Percent of all past problems that were wrong on this KC.}
#'   \item{totalFrPastWrongCount}{Total first responses wrong attempts in the tutor so far.}
#'   \item{frPast5WrongCount}{Number of last 5 First responses that were wrong}
#'   \item{frPast8WrongCount}{Number of last 8 First responses that were wrong}
#'   \item{totalFrTimeOnSkill}{Total first response time spent on this KC across all problems}
#'   \item{timeSinceSkill}{Time since the current KC was last seen.}
#'   \item{frWorkingInSchool}{First response Working during school hours (between 7:00 am and 3:00 pm)}
#'   \item{totalFrAttempted}{Total first responses attempted in the tutor so far.}
#'   \item{totalFrSkillOpportunities}{Total first response practice opportunities on this KC so far.}
#'   \item{responseIsFillIn}{Response is filled in (No list of answers available)}
#'   \item{responseIsChosen}{Response is chosen from a list of answers (Multiple choice, etc).}
#'   \item{endsWithScaffolding}{Problem ends with scaffolding}
#'   \item{endsWithAutoScaffolding}{Problem ends with automatic scaffolding}
#'   \item{frTimeTakenOnScaffolding}{First response time taken on scaffolding problems}
#'   \item{frTotalSkillOpportunitiesScaffolding}{Total first response practice opportunities on this skill so far}
#'   \item{totalFrSkillOpportunitiesByScaffolding}{Total first response scaffolding opportunities for this KC so far}
#'   \item{frIsHelpRequestScaffolding}{First response is a help request Scaffolding}
#'   \item{timeGreater5Secprev2wrong}{Long pauses after 2 Consecutive wrong answers}
#'   \item{sumRight}{}
#'   \item{helpAccessUnder2Sec}{Time spent on help was under 2 seconds}
#'   \item{timeGreater10SecAndNextActionRight}{Long pause after correct answer}
#'   \item{consecutiveErrorsInRow}{Total number of 2 wrong answers in a row across all the problems}
#'   \item{sumTime3SDWhen3RowRight}{}
#'   \item{sumTimePerSkill}{}
#'   \item{totalTimeByPercentCorrectForskill}{Total time spent on this KC across all problems divided by percent correct for the same KC}
#'   \item{prev5count}{}
#'   \item{timeOver80}{}
#'   \item{manywrong}{}
#'   \item{confidence(BORED)}{the confidence of the student affect prediction: bored}
#'   \item{confidence(CONCENTRATING)}{the confidence of the student affect prediction: concecntrating}
#'   \item{confidence(CONFUSED)}{the confidence of the student affect prediction: confused}
#'   \item{confidence(FRUSTRATED)}{the confidence of the student affect prediction: frustrated}
#'   \item{confidence(OFF TASK)}{the confidence of the student affect prediction: off task}
#'   \item{confidence(GAMING)}{the confidence of the student affect prediction: gaming}
#'   \item{RES_BORED}{rescaled of the confidence of the student affect prediction: boredom}
#'   \item{RES_CONCENTRATING}{rescaled of the confidence of the student affect prediction: concentration}
#'   \item{RES_CONFUSED}{rescaled of the confidence of the student affect prediction: confusion}
#'   \item{RES_FRUSTRATED}{rescaled of the confidence of the student affect prediction: frustration}
#'   \item{RES_OFFTASK}{rescaled of the confidence of the student affect prediction: off task}
#'   \item{RES_GAMING}{rescaled of the confidence of the student affect prediction: gaming}
#'   \item{Ln-1}{baysian knowledge tracing's knowledge estimate at the previous time step}
#'   \item{Ln}{baysian knowledge tracing's knowledge estimate at the time step}
#'   \item{}{}
#'   \item{schoolID}{the id (anonymized) of the school the student was in during the year the data was collected}
#'   \item{MCAS}{Massachusetts Comprehensive Assessment System test score. In short, this number is the student's state test score (outside ASSISTments) during that year. -999 represents the data is missing}
#' }
#' @source \url{https://sites.google.com/view/assistmentsdatamining/dataset}
"assistments"
