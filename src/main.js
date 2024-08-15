import '@exampledev/new.css';
import './styles.css';
function createHeader() {
    const headerElement = document.createElement(`header`);
    headerElement.innerHTML = `<h1>from Nepal</h1>`;
    return headerElement;
}
// Function to create a blog post element with tags and slug
function createBlogPostElement(post) {
    const postElement = document.createElement('article');
    const tagsHtml = post.tags.map(tag => `<span class="tag"><kbd>${tag}</kbd></span>`).join(' ');
    postElement.innerHTML = `
    <h2>${post.title}</h2>
    <!--<h3>${post.slug}</h3>-->
    <div class="tags">${tagsHtml}</div>
    <p>Created: <kbd>${post.createdAt}</kbd> | Modified: <kbd>${post.modifiedAt}</kbd></p>
    <p class="notice">${post.lede}</p>
    ${post.paragraphs.map(paragraph => `<p>${paragraph}</p>`).join('')}
  `;
    return postElement;
}
// Function to fetch and display blog posts
async function fetchAndDisplayPosts() {
    try {
        const response = await fetch('/posts.json');
        const data = await response.json();
        const postsContainer = document.getElementById('app');
        if (!postsContainer) {
            throw new Error('App container not found');
        }
        data.posts.forEach((post) => {
            const postElement = createBlogPostElement(post);
            postsContainer.appendChild(postElement);
        });
    }
    catch (error) {
        console.error('Error fetching posts:', error);
    }
}
async function fetchAndDisplayHeader() {
    const postsContainer = document.getElementById('app');
    if (!postsContainer) {
        throw new Error('App container not found');
    }
    const headerElement = createHeader();
    postsContainer.appendChild(headerElement);
}
async function displayFooter() {
    const postsContainer = document.getElementById('app');
    if (!postsContainer) {
        throw new Error('App container not found');
    }
    const footerElement = document.createElement(`footer`);
    footerElement.innerHTML = `Posts are also available as a <code>json</code> file at <a href="/posts.json">/posts.json</a>`;
    postsContainer.appendChild(footerElement);
}
function getCurrentTimeString() {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    return `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;
}
;
async function saveVisitData() {
    const formattedTime = getCurrentTimeString();
    const userAgent = navigator.userAgent;
    const visitData = {
        timestamp: formattedTime,
        userAgent: userAgent
    };
    const postEndpoint = `https://nice.runasp.net/Analytics/SaveAnalytics?key=visit${formattedTime}&data=${encodeURIComponent(JSON.stringify(visitData))}`;
    try {
        const postResponse = await fetch(postEndpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(visitData)
        });
        if (!postResponse.ok) {
            throw new Error('Network response was not ok');
        }
        console.log('Visit data saved:', await postResponse.text());
        // If the POST request is successful, make the GET request
        const getEndpoint = `https://nice.runasp.net/Analytics/GetAnalyticsData?key=visit${formattedTime}`;
        const getResponse = await fetch(getEndpoint);
        const data = await getResponse.json();
        if (getResponse.ok) {
            console.log('Verification successful, retrieved data:', data);
        }
        else {
            console.error('Verification failed, response was not ok');
        }
    }
    catch (error) {
        console.error('Error saving or verifying visit data:', error);
    }
}
;
async function main() {
    await fetchAndDisplayHeader();
    await fetchAndDisplayPosts();
    await displayFooter();
    await saveVisitData();
}
main();
