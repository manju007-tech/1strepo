use student_info;
SELECT 
    *
FROM
    student_list;
SELECT 
    *
FROM
    student_response;
SELECT 
    *
FROM
    correct_answer;
SELECT 
    *
FROM
    question_paper_code;


/*select sl.ï»¿roll_number, sl.student_name,sl.class,sl.section,sl.school_name,sr.option_marked,ca.correct_answer,qp.subject*/


with cte as
 (select sl.ï»¿roll_number, sl.student_name,sl.class,sl.section,sl.school_name,
 sum(case when qp.subject  =  'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end )as math_correct,
 sum(case when qp.subject  =  'Math' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end )as math_wrong,
 sum(case when qp.subject  =  'Math' and sr.option_marked = 'e' then 1 else 0 end )as math_yet_to_learn,
 sum(case when qp.subject  =  'Math' then 1 else 0 end )as total_math,
 sum(case when qp.subject  =  'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end )as Science_correct,
 sum(case when qp.subject  =  'Science' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e' then 1 else 0 end )as Science_wrong,
 sum(case when qp.subject  =  'Science' and sr.option_marked = 'e' then 1 else 0 end )as Science_yet_to_learn,
 sum(case when qp.subject  =  'Science' then 1 else 0 end )as total_Science
 from student_list sl
 join student_response sr on sl.ï»¿roll_number = sr.roll_number
 join correct_answer ca on sr.question_paper_code = ca.question_paper_code and sr.question_number = ca.question_number
 join question_paper_code qp on ca.question_paper_code = qp.ï»¿paper_code
 group by sl.ï»¿roll_number, sl.student_name,sl.class,sl.section,sl.school_name)
 select ï»¿roll_number as roll_number, student_name,class,section,school_name,math_correct,math_wrong,math_yet_to_learn,round((math_correct/total_math)*100,2) as math_per,
 Science_correct,Science_wrong,Science_yet_to_learn,round((Science_correct/total_Science)*100,2) as Science_per
 from cte;
 
 
