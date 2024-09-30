

HackerRank Home
|
Prepare
Certify
Compete
Apply
Search


|
Switch to..

civic
PrepareAlgorithmsWarmupCompare the Triplets
Compare the Triplets
9 more points to get your first star!
Rank: 3120968|Points: 21/30
Problem Solving
Problem
Submissions
Leaderboard
Discussions
Editorial
HackerRank Logo
|
PrepareAlgorithmsWarmupCompare the Triplets
Exit Full Screen View
Problem	Submissions	Leaderboard	Discussions	Editorial
Alice and Bob each created one problem for HackerRank. A reviewer rates the two challenges, awarding points on a scale from 1 to 100 for three categories: problem clarity, originality, and difficulty.

The rating for Alice's challenge is the triplet a = (a[0], a[1], a[2]), and the rating for Bob's challenge is the triplet b = (b[0], b[1], b[2]).

The task is to find their comparison points by comparing a[0] with b[0], a[1] with b[1], and a[2] with b[2].

If a[i] > b[i], then Alice is awarded 1 point.
If a[i] < b[i], then Bob is awarded 1 point.
If a[i] = b[i], then neither person receives a point.
Comparison points is the total points a person earned.

Given a and b, determine their respective comparison points.

Example

a = [1, 2, 3]
b = [3, 2, 1]

For elements *0*, Bob is awarded a point because a[0] .
For the equal elements a[1] and b[1], no points are earned.
Finally, for elements 2, a[2] > b[2] so Alice receives a point.
The return array is [1, 1] with Alice's score first and Bob's second.

Function Description

Complete the function compareTriplets in the editor below.

compareTriplets has the following parameter(s):

int a[3]: Alice's challenge rating
int b[3]: Bob's challenge rating
Return

int[2]: Alice's score is in the first position, and Bob's score is in the second.
Input Format

The first line contains 3 space-separated integers, a[0], a[1], and a[2], the respective values in triplet a.
The second line contains 3 space-separated integers, b[0], b[1], and b[2], the respective values in triplet b.

Constraints

1 ≤ a[i] ≤ 100
1 ≤ b[i] ≤ 100
Sample Input 0

5 6 7
3 6 10
Sample Output 0

1 1
Explanation 0

In this example:

Now, let's compare each individual score:

, so Alice receives  point.
, so nobody receives a point.
, so Bob receives  point.
Alice's comparison score is , and Bob's comparison score is . Thus, we return the array .

Sample Input 1

17 28 30
99 16 8
Sample Output 1

2 1
Explanation 1

Comparing the  elements,  so Bob receives a point.
Comparing the  and  elements,  and  so Alice receives two points.
The return array is .

Language
C#
More
12345678910111213141516171819202122232425262728424344454647484950515253545529303132403533343637383941
        return result;
    }

}

class Solution
{
    public static void Main(string[] args)
    {
        TextWriter textWriter = new StreamWriter(@System.Environment.GetEnvironmentVariable("OUTPUT_PATH"), true);



Line: 41 Col: 23

Test against custom input
Congratulations!

You have passed the sample test cases. Click the submit button to run your code against all the test cases.


Sample Test case 0

Sample Test case 1
Input (stdin)
5 6 7
3 6 10
Your Output (stdout)
1 1
Expected Output
1 1
BlogScoringEnvironmentFAQAbout UsSupportCareersTerms Of ServicePrivacy Policy
int capacity, The number of elements that the new list can initially store., Initializes a new instance of the System.Collections.Generic.List`1 class that is empty and has the specified initial capacity., hint

```csharp
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Collections;
using System.ComponentModel;
using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;
using System.Text.RegularExpressions;
using System.Text;
using System;

class Result
{

    /*
     * Complete the 'compareTriplets' function below.
     *
     * The function is expected to return an INTEGER_ARRAY.
     * The function accepts following parameters:
     *  1. INTEGER_ARRAY a
     *  2. INTEGER_ARRAY b
     */

    public static List<int> compareTriplets(List<int> a, List<int> b)
    {
        List<int> result = [ 0, 0 ];
        for (int i = 0; i < 3; i++)
        {
            if (a[i] > b[i])
            {
                result[0] = result[0] + 1;
            }
            if (b[i] > a[i])
            {
                result[1] = result[1] + 1;
            }
        }
        return result;
    }

}

class Solution
{
    public static void Main(string[] args)
    {
        TextWriter textWriter = new StreamWriter(@System.Environment.GetEnvironmentVariable("OUTPUT_PATH"), true);

        List<int> a = Console.ReadLine().TrimEnd().Split(' ').ToList().Select(aTemp => Convert.ToInt32(aTemp)).ToList();

        List<int> b = Console.ReadLine().TrimEnd().Split(' ').ToList().Select(bTemp => Convert.ToInt32(bTemp)).ToList();

        List<int> result = Result.compareTriplets(a, b);

        textWriter.WriteLine(String.Join(" ", result));

        textWriter.Flush();
        textWriter.Close();
    }
}

```