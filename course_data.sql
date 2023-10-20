INSERT INTO course (course_id,course_name,course_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('5','LAW','Civil Procedure Code','0','1',NULL,'2023-10-12 14:06:47','1','2023-10-19 20:54:54',NULL);

INSERT INTO subject (subject_id,course_id,subject_name,subject_desc,note_name,note_url,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('6','5','Civil Procedure Code','Civil Procedure Code','1.pdf','notes/1697729828769.pdf','0','1',NULL,'2023-10-12 14:07:26',NULL,'2023-10-19 21:07:08',NULL);
INSERT INTO subject (subject_id,course_id,subject_name,subject_desc,note_name,note_url,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('7','5','Robotics','Robotics Video Course','Kitting.pdf','notes/1697099876616.pdf','0','1',NULL,'2023-10-12 14:07:56',NULL,'2023-10-12 08:37:56',NULL);INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('10','6','videoes/1697729892390.mp4','CPC Video 1','','Civil Procedure Code','0','1',NULL,'2023-10-19 21:08:13',NULL,'2023-10-19 21:59:52',NULL);

INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('11','6','videoes/1697733094107.mp4','CPC Video 2','mp4','Civil Procedure Code','0','1',NULL,'2023-10-19 22:01:35',NULL,'2023-10-19 16:31:35',NULL);

INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('12','6','videoes/1697733450519.mp4','CPC Video 3','mp4','Civil Procedure Code','0','1',NULL,'2023-10-19 22:07:31',NULL,'2023-10-19 16:37:31',NULL);

INSERT INTO video (video_id,subject_id,video_path,video_name,video_extension,video_desc,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('13','6','videoes/1697733608620.mp4','CPC Video 4','mp4','Civil Procedure Code','0','1',NULL,'2023-10-19 22:10:10',NULL,'2023-10-19 16:40:10',NULL);
INSERT INTO note (note_id,subject_id,note_name,note_path,note_desc,note_extension,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('6','6','CPC Notes','notes/1697733759279.pdf','Civil Procedure Code','pdf','0','1',NULL,'2023-10-12 14:08:55',NULL,'2023-10-19 22:12:39',NULL);
INSERT INTO note (note_id,subject_id,note_name,note_path,note_desc,note_extension,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('7','7','Title','notes/1697100258367.pdf','Sub Title','pdf','0','1',NULL,'2023-10-12 14:14:18',NULL,'2023-10-12 08:44:18',NULL);
INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('38','6','Which of the following deals with the statement and production of evidence in the Code of Civil Procedure?','1','Order 18, Rule 2','Order 12, Rule 5','Order 14, Rule 20','Order 18, Rule 2','Order 11, Rule 7','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('39','6','Which of the following deals with the right to challenge non-appealable orders in appeal against decrees in the Code of Civil Procedure?','1','Order 43, Rule 1A','Order 43, Rule 1A','Order 14, Rule 20','Order 18, Rule 2','Order 11, Rule 7','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('40','6','In order for that a decision in a former suit may operate as res judicata, the court which may decide that suit must have been?
I. A civil court of competent jurisdiction

II. A court of exclusive jurisdiction

III. A court of concurrent jurisdiction competent to try the subsequent suit

IV. A court of limited jurisdiction competent to try the issue raised in the subsequent suit','1','All of these','Either I or III','Either II or III','Either III or IV','All of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('41','6','In transaction for transfer or delivery of the property attached, where the contract is executed and registered before attachment, the mischief of sub-s (1) shall not apply. However in which of the following situation it applies?','1','Both (A) and (B)','Where the property is transferred and registered after attachment','Where the property is transferred before attachment but registration takes place after the attachment','Both (A) and (B)','None of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('42','6','The court to amend a decree is the court that passed it. Where an appeal is preferred from a decree of a court of first instance the Appellate Court may:','1','Either (A) or (B)','Dismiss the appeal under O. 41, r 11(1), without issuing any notice to the respondents','Confirm, reverse or vary the decree of the court of first instance (O. 41, r 32)','Either (A) or (B)','None of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('43','6','Which of the following tests are to be applied in cases where the plea of bar of the suit under O. 2, r 2 is raised?','1','all of these','Whether the cause of action in the previous suit and that in the subsequent suit are identical','Whether the relief claimed in the subsequent suit could have been given in the previous suit on the basis of the pleadings filed in that suit','Whether the plaintiff omitted to sue for a particular relief on the cause of action which had been disclosed in the previous suit','all of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('44','6','An order under O. 33, r 11 directing the pauper plaintiff to pay the Court-fees can only be made in which of the following cases?

I. Where the plaintiff fails in the suit

II. Where the plaintiff is dispaupered under r 9

III. Where the suit is withdrawn

IV. Where the suit is dismissed under the circumstances specified in cl. (a) or cl. (b)','1','all of the above','I, III, IV','II, IV','III, IV','all of the above','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('45','6','The words it appears to the Central Government which is the consenting authority, makes it clear that:','1','The decision granting the consent is final','The decision granting the consent is open to question by the court','The decision granting the consent is final','Either (A) or (B)','None of these','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('46','6','The word resides used in s. 19 of the Code of Civil Procedure means:','1','Natural persons','Natural persons','Companies','Tort','all of the above','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('47','6','Bar to further suit is dealt under which of the following in the Code of Civil Procedure?','1','Section 12','Section 11','Section 12','Section 16','Section 36','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('48','6','Which of the following deals with the transfer of decree in the Code of Civil Procedure?','1','Section 39','Section 41','Section 36','Section 49','Section 39','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('49','6','Which of the following has been repealed by s. 7 of the Code of Civil Procedure (Amendment) Act 66 of 1956 in the Code of Civil Procedure?

I. Section 68

II. Section 69

III. Section 70

IV. Section 71

V. Section 72','1','All of them','I, III, IV','II, III, V','Ill, IV, V','All of them','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('50','6','No order under section 47 to be refused or modified unless decision of the case is prejudicially affected under which of the following in the Code of Civil Procedure?','1','Section 99A','Section 90A','Section 95A','Section 99A','Section 101B','','0','1',NULL,'2023-10-19 22:20:29',NULL,'2023-10-19 16:50:29',NULL);
INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('14','7','question b','1','b','a','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('15','7','question c','1','c','a','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('16','7','question d','1','d','a','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('17','7','question aa','1','aa','aa','b','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);

INSERT INTO quiz (quiz_id,subject_id,question,question_type,answer,option1,option2,option3,option4,option5,is_delete,is_active,created_by,created_date,modified_by,modified_date,ip_address) VALUES ('18','7','question bb','1','bb','a','bb','c','d','','0','1',NULL,'2023-10-12 14:13:51',NULL,'2023-10-12 08:43:51',NULL);
