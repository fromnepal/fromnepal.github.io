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

1. Users access websites through domain names, such as api.mysite.com 
The domain name system (DNS), which is a separate system, resolves it to an IP address. 
2. DNS server returns an IP address to the user (client application such as a web browser or some other application such as a mobile app). 
In the case of a single server setup, this IP address is directly associated with our server. 
3. Once an IP address is obtained, the client application sends a request to the web server. 
4. The web server does some work and returns the response, typically some HTML page or some JSON document for rendering. 

One of the first things we can do when scaling our application for more users is to add multiple servers, 
one for web/mobile traffic and the other for the database. 
This allows us to scale the two concerns separately. 

So to rewrite the above flow: 

1. Users access websites through domain names, such as api.mysite.com 
The domain name system (DNS), which is a separate system, resolves it to an IP address. 
2. DNS server returns an IP address to the user (client application such as a web browser or some other application such as a mobile app). 
In the case of a single server setup, this IP address is directly associated with our server. 
3. Once an IP address is obtained, the client application sends a request to the web server. 
4. The web server does some work and sends a request to the database server to create / read / write / update data on the database server. 
5. The database server returns a response on which the web server does some work again 
and returns the response, typically some HTML page or some JSON document for rendering. 

There are two main choices for databases: 

1. a traditional relational database 
2. a non-relational database 

Both have benefits and drawbacks. 

Relational databases such as MySQL, PostgreSQL, Microsoft SQL Server, and Oracle database store and represent data in tables and rows. 
They allow us to perform join operations using SQL across tables. 

Non relational databases such as CouchDB, Neo4j, Cassandra, HBase, and Amazon DynamoDB can be grouped into four categories: 
1. key value stores 
2. graph stores
3. column stores 
4. document stores

Join operations are generally not supporeted in non-relational databases. 

Relational databases are usually the best option. 
They have been around for over forty years and historically have worked well. 
Some reasons to explore non-relational databases include: 

1. application requires super low latency 
2. Data is unstructured, or data does not contain any relation 
3. You only need to serialize and deserialize data (JSON, XML, YAML) etc 
4. You need to store a massive amount of data 

Vertical vs horizontal scaling 

Vertical scaling is known as scale up 
and it adds more resources (processor, memory, etc) to an existing server. 
Horizontal scaling is known as scale out 
and it adds more servers into an existing pool of resources. 

Vertical scaling is great for smaller applications where traffic is low. 
It is simple and does not require any change in logic. 
However, vertical scaling has limits: 
1. There is a limit to how much processor (CPU) and memory (RAM) we can add to a single server. 
Even with the best server, there is only ONE server. 
2. There is no failover or redundancy. 
If a server goes down, it takes the application down with it. 

For large scale applications, we find horizontal scaling to be more desirable. 
A relatively simple way to achieve horizontal scaling is a load balancer. 
Here, instead of a user agent reaching the setb server directly, 
they reach the load balancer which forwards the request to any available web server. 
This allows the user to reach a server if another server is offline. 
This also allows many users to access a server simultaneously 
when this would have exhausted the limits of one server's load limit 
and caused slow responses or failed connection attempts with a single server. 

A load balancer distributes incoming traffic among web servers defined in a load-balanced set. 
Users connect to the public IP address which is now associated with the load balancer, rather than any individual web server. 
Users cannot reach individual web server anymore. 
A private IP address is used for communication between the servers which is only reachable between servers on the same network. 
The load balancer communicated with web server through these private IP addresses. 

1. If an application server goes offline, all thriffic will be routed to the other servers. 
This prevents the website from going offline if one application server is offline. 
We will also add a new healthy server to the server pool o


Virtual loop interview for [redacted], Software Development Engineer II, Alexa Subscriptions Growth + Alexa Communications
