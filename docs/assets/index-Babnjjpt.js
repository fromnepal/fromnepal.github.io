(function(){const o=document.createElement("link").relList;if(o&&o.supports&&o.supports("modulepreload"))return;for(const t of document.querySelectorAll('link[rel="modulepreload"]'))r(t);new MutationObserver(t=>{for(const n of t)if(n.type==="childList")for(const a of n.addedNodes)a.tagName==="LINK"&&a.rel==="modulepreload"&&r(a)}).observe(document,{childList:!0,subtree:!0});function s(t){const n={};return t.integrity&&(n.integrity=t.integrity),t.referrerPolicy&&(n.referrerPolicy=t.referrerPolicy),t.crossOrigin==="use-credentials"?n.credentials="include":t.crossOrigin==="anonymous"?n.credentials="omit":n.credentials="same-origin",n}function r(t){if(t.ep)return;t.ep=!0;const n=s(t);fetch(t.href,n)}})();function i(){const e=document.createElement("header");return e.innerHTML="<h1>from Nepal</h1>",e}function c(e){const o=document.createElement("article"),s=e.tags.map(r=>`<span class="tag"><kbd>${r}</kbd></span>`).join(" ");return o.innerHTML=`
    <h2>${e.title}</h2>
    <!--<h3>${e.slug}</h3>-->
    <div class="tags">${s}</div>
    <p>Created: <kbd>${e.createdAt}</kbd> | Modified: <kbd>${e.modifiedAt}</kbd></p>
    <p class="notice">${e.lede}</p>
    ${e.paragraphs.map(r=>`<p>${r}</p>`).join("")}
  `,o}async function l(){try{const o=await(await fetch("/posts.json")).json(),s=document.getElementById("app");if(!s)throw new Error("App container not found");o.posts.forEach(r=>{const t=c(r);s.appendChild(t)})}catch(e){console.error("Error fetching posts:",e)}}async function d(){const e=document.getElementById("app");if(!e)throw new Error("App container not found");const o=i();e.appendChild(o)}async function p(){const e=document.getElementById("app");if(!e)throw new Error("App container not found");const o=document.createElement("footer");o.innerHTML=`
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
    
    Posts are also available as a <code>json</code> file at <a href="/posts.json">/posts.json</a>`,e.appendChild(o)}async function u(){await d(),await l(),await p()}u();
