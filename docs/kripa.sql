SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND city  = 'SQL City'
AND [date] = 20180115
-- Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

          
SELECT *
FROM person p
WHERE 
	p.address_street_name = 'Northwestern Dr' 
order by 
	address_number desc
-- limit 1;
-- id	name	license_id	address_number	address_street_name	ssn
-- 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

SELECT *
FROM person p
WHERE 
	p.address_street_name = 'Franklin Ave' 
	and name like '%annabel%'
-- id	name	license_id	address_number	address_street_name	ssn
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

select * from interview where person_id in (14887, 16371);
-- person_id	transcript
-- 14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- 16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

select * from drivers_license where plate_number like '%H42W%'
-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius
-- 423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
-- 664760	21	71	black	black	male	4H42WR	Nissan	Altima

select * from drivers_license dl
inner join person p on p.license_id = dl.id
where plate_number like '%H42W%'
-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model	id	name	license_id	address_number	address_street_name	ssn
-- 664760	21	71	black	black	male	4H42WR	Nissan	Altima	51739	Tushar Chandra	664760	312	Phi St	137882671
-- 423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS	67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279
-- 183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius	78193	Maxine Whitely	183779	110	Fisk Rd	137882671

select p.id from drivers_license dl
inner join person p on p.license_id = dl.id
where plate_number like '%H42W%'

select * from get_fit_now_member 
where person_id in 
(
  select p.id from drivers_license dl
  inner join person p on p.license_id = dl.id
  where plate_number like '%H42W%'
 );

-- id	person_id	name	membership_start_date	membership_status
-- 48Z55	67318	Jeremy Bowers	20160101	gold

select * from get_fit_now_member 
where person_id in 
(
  select p.id from drivers_license dl
  inner join person p on p.license_id = dl.id
  where plate_number like '%H42W%'
 )
 and membership_status = 'gold';
--  id	person_id	name	membership_start_date	membership_status
-- 48Z55	67318	Jeremy Bowers	20160101	gold

select * from get_fit_now_check_in where check_in_date = 20180109;
-- membership_id	check_in_date	check_in_time	check_out_time
-- X0643	20180109	957	1164
-- UK1F2	20180109	344	518
-- XTE42	20180109	486	1124
-- 1AE2H	20180109	461	944
-- 6LSTG	20180109	399	515
-- 7MWHJ	20180109	273	885
-- GE5Q8	20180109	367	959
-- 48Z7A	20180109	1600	1730
-- 48Z55	20180109	1530	1700
-- 90081	20180109	1600	1700

select * from 
get_fit_now_member 
left join get_fit_now_check_in
on get_fit_now_member.id = get_fit_now_check_in.membership_id
where check_in_date = 20180109
and membership_id like '48Z55'
-- id	person_id	name	membership_start_date	membership_status	membership_id	check_in_date	check_in_time	check_out_time
-- 48Z55	67318	Jeremy Bowers	20160101	gold	48Z55	20180109	1530	1700

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;
-- value
-- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.

select * from interview where person_id = 67318
-- person_id	transcript
-- 67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. 

select * from drivers_license where car_make = 'Tesla' and car_model = 'Model S' and hair_color = 'red' and gender = 'female' and height >= 65 and height <= 67
-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 202298	68	66	green	red	female	500123	Tesla	Model S
-- 291182	65	66	blue	red	female	08CM64	Tesla	Model S
-- 918773	48	65	black	red	female	917UU3	Tesla	Model S

