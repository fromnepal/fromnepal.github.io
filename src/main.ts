import '@exampledev/new.css';
import './styles.css'
// Define the interface for a blog post based on the JSON structure
interface BlogPost {
  title: string;
  createdAt: string;
  modifiedAt: string;
  tags: string[];
  slug: string;
  lede: string;
  paragraphs: string[];
}

function createHeader() {
  const headerElement = document.createElement(`header`);
  headerElement.innerHTML = `<h1>from Nepal</h1>`;
  return headerElement;
}

// Function to create a blog post element with tags and slug
function createBlogPostElement(post: BlogPost): HTMLElement {
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

    data.posts.forEach((post: BlogPost) => {
      const postElement = createBlogPostElement(post);
      postsContainer.appendChild(postElement);
    });
  } catch (error) {
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
  footerElement.innerHTML = `
    **General Disclaimers**

    <p>May contain nuts, but not the kind that'll make you smarter.<p>
    <p>Side effects of using this website may include: procrastination, eye strain, and a sudden urge to watch cat videos.<p>
    <p>Not responsible for any spontaneous outbursts of laughter, tears, or existential crises.<p>

    **Financial Disclaimers**

    <p>Investments may go down in value, but our excuses for why they did will always be creative.<p>
    <p>Past performance is not indicative of future success, but hey, at least we tried.<p>
    <p>Risk of financial loss is high, but the risk of boredom is even higher if you don't take a chance.<p>

    **Health and Wellness Disclaimers**

    <p>Our fitness advice is not intended to replace medical professionals, but our trainers are pretty sure they know what they're doing.<p>
    <p>Results not typical, but we'll make you feel guilty for not achieving them anyway.<p>
    <p>Side effects of our wellness program may include: increased energy, improved mood, and a sudden urge to post about it on social media.<p>

    **Technology Disclaimers**

    <p>Our website may be down for maintenance, but our excuses for why it's down will always be up.<p>
    <p>Not responsible for any data lost, stolen, or used for nefarious purposes (but let's be real, it's probably just a cat video).<p>
    <p>Our app is not intended for use while operating heavy machinery, but we won't judge you if you do.<p>

    **Miscellaneous Disclaimers**

    <p>Our opinions are not facts, but they're definitely more interesting than facts.<p>
    <p>Not responsible for any relationships ruined by our dating advice, but we'll take credit for the ones that work out.<p>
    <p>Our website is not intended for use by anyone under the age of 13, but let's be real, kids are way more tech-savvy than we are.<p>
    
    Posts are also available as a <code>json</code> file at <a href="/posts.json">/posts.json</a>`;
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
};

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
    } else {
      console.error('Verification failed, response was not ok');
    }
  } catch (error) {
    console.error('Error saving or verifying visit data:', error);
  }
};


async function main() {
  await fetchAndDisplayHeader();
  await fetchAndDisplayPosts();
  await displayFooter();
  await saveVisitData();
}
main();
