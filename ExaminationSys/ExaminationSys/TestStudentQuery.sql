exec auth

------- Student ------

-- ExamId -- StdId
exec ShowExamSP 12, 1003

-- StdAnswer - QstId - QstType - StdId - ExamId
exec AnswerThisQstSP '1Mohamed Omar', 3, 'TXQ', 1003, 12
-- StdAnswer - QstId - QstType - StdId - ExamId
exec AnswerThisQstSP '1', 3, 'MCQ', 1003, 12
-- StdAnswer - QstId - QstType - StdId - ExamId
exec AnswerThisQstSP '1', 3, 'TFQ', 1003, 12
-- StdAnswer - QstId - QstType - StdId - ExamId
exec AnswerThisQstSP 'Mohamed Omar TSSSST', 1, 'TXQ', 1003, 12

-- SId -- ExamId
exec SubmitExamSP 1003, 12

