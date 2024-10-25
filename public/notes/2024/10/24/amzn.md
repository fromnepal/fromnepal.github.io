# Amazon 

## Technical competencies SDE Topics 

Coding: 

1. Problem solving 
2. Data structures and algorithms
3. Logical and maintainable 

System design: 

4. Scalability and operational performance 

Behavioral competencies 

Leadership principles 

1. Learn and be curious 
2. Insist on highest standards 
3. Customer obsession 
4. Ownership 
5. Deliver results 
6. Deep dive 
7. Have backbone; disagree and commit 
8. Earn trust
9. Invent and simplify



There are four interview rounds. 
Each has a technical bucket and a behavioral bucket. 



Coding: 
For any coding questions, ask clarifying questions before writing any code. 
Tell them clearly what you are doing and where you are going toward. 
After coding, test your code. 
If you run out of time before you reach the optimal solution, 
let the interviewer know where you are leaning toward. 

## Problem solving: 
Spend at least five minutes asking clarifying questions. 
Try to identify the edge cases beforehand. 
Time management is key. 
Tell the interviewer what you are planning to do. 
Let the interviewer know if you are stuck. 
If you identify a problem with multiple solutions, 
tell them how you are comparing and contrasting the solutions. 
Given x, y, z create a robot that has move method with a string of commands. 

## Logical and maintainable 
The expectation is to produce production ready code that is clean, concise, and scalable. 
The level of perfection is production ready. 
It may not be attainable in the given time limit. 
It is OK. 
Try your best. 
Finish your coding with the perfect code. 
Leaving your code perfect in half is better than imperfect code. 
Code does not have to be 100% optimized but it should convey the intent and logic correctly. 
Be familiar with object oriented best practices and abstract helping method to help extend your code. 
Implement a customer service call dispatch. 

## Data structures 
Know the strengths and weaknesses of any data structure that you choose. 
Could you implement it? 
How and why would you use the given data structure in that particular situation? 
Sometimes you can't solve a problem with a single data structure, how will you solve a problem with multiple data structures? 
Consider run times for common operations and how they use memory. 
Understand data structures in common core libraries like trees, hash maps, lists, arrays, queues, etc. 
Algorithms: expectation is to handle edge cases in the problem we are working with, not memorize/repeat every algorithm ever.  
Understand common algorithms: Traversal / divide and conquer, when to use breadth vs depth, recursion, etc. 
Discuss the runtimes, theoretical limitations and basic implementation strategies for different classes of algorithms. 
Find ways to optimize your solution and find optimal time complexity. 
Example question: How would you remove duplicates from a given array in Java? 

## System design
Question will be a little vague. 
It will be just a one liner question. 
Expectation from the interviewer is that you will ask clarifying questions. 
Understand who you are designing the system for and why. 
What is the expectation that they have for functionality? 
What things could the customer just assume will be in the system but they will not think about it in front of their mind? 
Software systems need software components: 
    i. Something to store data 
    ii. Something make decisions 
    iii. APIs or processes 
Distributed systems, SOA, and entire software architecture
Practice drawing system design by hand and on platforms such as invision 
What if the service will become hyper popular with 10x as many customers as expected? 
How will you improve the current system to meet demand? 
Feel free to create a diagram if it helps clarify your thoughts. 
Write down the requirements or assumptions you are making and make your design based on them. 






System design: 
Imagine you are building an app that backs up photos for customers. 
The app already has the following solved for it: login and authentication, logging, crash handling, UX that scales for one million plus photos or videos. The service has been built to accept images to it at Amazon scale up to at least five thousand images uploaded a second. Your job in the app is to design the code that will queue up photos or videos stored on the customer's device and make sure they are backed up to the cloud. Things that you would want to consider are our customers on average store 90% photos and 10% videos in their gallery. Photos are on average 5 MB a piece and videos can range from 45 MB per minute to 1 GB per minute. Customers can have between one to a hundred thousand photos or videos to backup depending if they are doing it for the first time or subsequent time. The app should be able to discern between what has already been uploaded in the past and what has not been uploaded. The app should continue where it left off in the back up process if the app crashes or the phone shuts down or loses Internet connection. 