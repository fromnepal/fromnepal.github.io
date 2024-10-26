# Amazon 

## Technical Competencies for SDE Topics 

### Coding 

1. Problem solving 
2. Data structures and algorithms
3. Logical and maintainable code 

### System Design 

1. Scalability 
2. Operational performance 

## Behavioral Competencies 

### Leadership Principles 

1. Learn and be curious 
2. Insist on highest standards 
3. Customer obsession 
4. Ownership 
5. Deliver results 
6. Deep dive 
7. Have backbone; disagree and commit 
8. Earn trust 
9. Invent and simplify 

## Interview Structure 

There are four interview rounds, each consisting of a technical bucket and a behavioral bucket.

### Coding Guidelines 

- Ask clarifying questions before writing any code. 
- Clearly communicate your thought process and direction. 
- Test your code after implementation. 
- If time runs out before reaching the optimal solution, inform the interviewer of your intended direction.

### Problem Solving 

- Spend at least five minutes asking clarifying questions. 
- Identify edge cases beforehand. 
- Manage your time effectively. 
- Communicate your plan to the interviewer. 
- Inform the interviewer if you get stuck. 
- Compare and contrast multiple solutions if applicable. 
- Example task: Given x, y, z, create a robot with a `move` method that accepts a string of commands.

### Logical and Maintainable Code 

- Aim to produce production-ready code that is clean, concise, and scalable. 
- Perfection may not be attainable within the time limit; do your best. 
- It's better to leave code perfect in half than to submit imperfect code. 
- Code should convey intent and logic correctly, even if not 100% optimized. 
- Familiarize yourself with object-oriented best practices and abstract helper methods. 
- Example task: Implement a customer service call dispatch.

### Data Structures 

- Understand the strengths and weaknesses of chosen data structures. 
- Be prepared to implement them and explain their use in specific situations. 
- Consider how to solve problems using multiple data structures when necessary. 
- Analyze run times for common operations and memory usage. 
- Familiarize yourself with common data structures in core libraries (e.g., trees, hash maps, lists, arrays, queues). 
- Understand common algorithms: traversal, divide and conquer, breadth vs. depth, recursion, etc. 
- Discuss runtimes, theoretical limitations, and basic implementation strategies. 
- Example question: How would you remove duplicates from a given array in Java?

### System Design 

- Expect vague, one-liner questions. 
- Ask clarifying questions to understand the system's purpose and user expectations. 
- Identify assumptions customers may have about the system's functionality. 

#### Software Components 

1. Data storage 
2. Decision-making processes 
3. APIs or processes 

- Consider distributed systems, SOA, and overall software architecture. 
- Practice drawing system designs by hand or on platforms like InVision. 
- Plan for scalability in case of unexpected demand (e.g., 10x customer growth). 
- Create diagrams to clarify your thoughts. 
- Document requirements and assumptions to guide your design.

### Example System Design Task 

Imagine you are building an app that backs up photos for customers. 

**Existing Features:**
- Login and authentication 
- Logging 
- Crash handling 
- UX that scales for over one million photos or videos 

**Requirements:**
- The service can accept up to 5,000 images uploaded per second. 
- Customers typically store 90% photos and 10% videos. 
- Average photo size: 5 MB; video size: 45 MB per minute to 1 GB per minute. 
- Customers may have between 1 to 100,000 photos/videos to back up. 
- The app should discern between previously uploaded and new content. 
- It should resume backups after crashes, phone shutdowns, or lost internet connections.





System Design Interview - Chapter 1: Scale from zero to millions of users 

## Single server setup 
Everything is running on one server 
    i. web app 
    ii. database 
    iii. cache 
    ... etc 

