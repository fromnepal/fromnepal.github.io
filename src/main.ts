import 'simpledotcss/simple.min.css';

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

fetchAndDisplayHeader();
fetchAndDisplayPosts();
