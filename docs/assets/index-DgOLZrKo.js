(function(){const o=document.createElement("link").relList;if(o&&o.supports&&o.supports("modulepreload"))return;for(const n of document.querySelectorAll('link[rel="modulepreload"]'))s(n);new MutationObserver(n=>{for(const t of n)if(t.type==="childList")for(const a of t.addedNodes)a.tagName==="LINK"&&a.rel==="modulepreload"&&s(a)}).observe(document,{childList:!0,subtree:!0});function r(n){const t={};return n.integrity&&(t.integrity=n.integrity),n.referrerPolicy&&(t.referrerPolicy=n.referrerPolicy),n.crossOrigin==="use-credentials"?t.credentials="include":n.crossOrigin==="anonymous"?t.credentials="omit":t.credentials="same-origin",t}function s(n){if(n.ep)return;n.ep=!0;const t=r(n);fetch(n.href,t)}})();function i(){const e=document.createElement("header");return e.innerHTML="<h1>from Nepal</h1>",e}function c(e){const o=document.createElement("article"),r=e.tags.map(s=>`<span class="tag"><kbd>${s}</kbd></span>`).join(" ");return o.innerHTML=`
    <h2>${e.title}</h2>
    <!--<h3>${e.slug}</h3>-->
    <div class="tags">${r}</div>
    <p>Created: <kbd>${e.createdAt}</kbd> | Modified: <kbd>${e.modifiedAt}</kbd></p>
    <p class="notice">${e.lede}</p>
    ${e.paragraphs.map(s=>`<p>${s}</p>`).join("")}
  `,o}async function d(){try{const o=await(await fetch("/posts.json")).json(),r=document.getElementById("app");if(!r)throw new Error("App container not found");o.posts.forEach(s=>{const n=c(s);r.appendChild(n)})}catch(e){console.error("Error fetching posts:",e)}}async function l(){const e=document.getElementById("app");if(!e)throw new Error("App container not found");const o=i();e.appendChild(o)}async function p(){const e=document.getElementById("app");if(!e)throw new Error("App container not found");const o=document.createElement("footer");o.innerHTML=`
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
    
    Posts are also available as a <code>json</code> file at <a href="/posts.json">/posts.json</a>`,e.appendChild(o)}function u(){const e=new Date,o=e.getFullYear(),r=String(e.getMonth()+1).padStart(2,"0"),s=String(e.getDate()).padStart(2,"0"),n=String(e.getHours()).padStart(2,"0"),t=String(e.getMinutes()).padStart(2,"0"),a=String(e.getSeconds()).padStart(2,"0");return`${o}-${r}-${s}-${n}-${t}-${a}`}async function f(){const e=u(),o=navigator.userAgent,r={timestamp:e,userAgent:o},s=`https://nice.runasp.net/Analytics/SaveAnalytics?key=visit${e}&data=${encodeURIComponent(JSON.stringify(r))}`,n=`https://nice.runasp.net/Analytics/GetAnalyticsData?key=visit${e}`;fetch(s,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(r)}).then(t=>{if(!t.ok)throw new Error("Network response was not ok");return t.text()}).then(()=>{fetch(n,{method:"GET",headers:{accept:"*/*"}}).then(t=>t.json()).then(t=>{console.log("Verified visit data:",t),JSON.stringify(t)!==JSON.stringify(r)&&console.error("Verified data does not match saved data")}).catch(t=>{console.error("Error verifying visit data:",t)})}).catch(t=>{console.error("Error saving visit data:",t)})}async function h(){await l(),await d(),await p(),await f()}h();
