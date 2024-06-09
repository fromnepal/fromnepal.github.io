

```powershell
> cd "C:\Users\kushal\src\myhtml\fromnepal"; date; yarn; date; yarn run build; date; git add .; date; git commit --message "build application" --message "from the terminal"; date; git pull --rebase origin main; date; git push origin main; date;

Sunday, June 9, 2024 12:33:44 PM
yarn install v1.22.21
[1/4] Resolving packages...
success Already up-to-date.
Done in 0.06s.
Sunday, June 9, 2024 12:33:44 PM
yarn run v1.22.21
$ tsc && vite build
vite v5.2.13 building for production...
✓ 5 modules transformed.
x Build failed in 81ms
error during build:
[vite:esbuild-transpile] Transform failed with 3 errors:
assets/index-!~{001}~.js:127:0: ERROR: Top-level await is not available in the configured target environment ("chrome87", "edge88", "es2020", "firefox78", "safari14" + 2 overrides)
assets/index-!~{001}~.js:128:0: ERROR: Top-level await is not available in the configured target environment ("chrome87", "edge88", "es2020", "firefox78", "safari14" + 2 overrides)
assets/index-!~{001}~.js:129:0: ERROR: Top-level await is not available in the configured target environment ("chrome87", "edge88", "es2020", "firefox78", "safari14" + 2 overrides)

Top-level await is not available in the configured target environment ("chrome87", "edge88", "es2020", "firefox78", "safari14" + 2 overrides)
125|    postsContainer.appendChild(footerElement);
126|  }
127|  await fetchAndDisplayHeader();
   |  ^
128|  await fetchAndDisplayPosts();
129|  await displayFooter();

Top-level await is not available in the configured target environment ("chrome87", "edge88", "es2020", "firefox78", "safari14" + 2 overrides)
126|  }
127|  await fetchAndDisplayHeader();
128|  await fetchAndDisplayPosts();
   |  ^
129|  await displayFooter();

Top-level await is not available in the configured target environment ("chrome87", "edge88", "es2020", "firefox78", "safari14" + 2 overrides)
127|  await fetchAndDisplayHeader();
128|  await fetchAndDisplayPosts();
129|  await displayFooter();
   |  ^

    at failureErrorWithLog (C:\Users\kushal\src\myhtml\fromnepal\node_modules\esbuild\lib\main.js:1651:15)
    at C:\Users\kushal\src\myhtml\fromnepal\node_modules\esbuild\lib\main.js:849:29
    at responseCallbacks.<computed> (C:\Users\kushal\src\myhtml\fromnepal\node_modules\esbuild\lib\main.js:704:9)
    at handleIncomingPacket (C:\Users\kushal\src\myhtml\fromnepal\node_modules\esbuild\lib\main.js:764:9)
    at Socket.readFromStdout (C:\Users\kushal\src\myhtml\fromnepal\node_modules\esbuild\lib\main.js:680:7)
    at Socket.emit (node:events:519:28)
    at addChunk (node:internal/streams/readable:559:12)
    at readableAddChunkPushByteMode (node:internal/streams/readable:510:3)
    at Readable.push (node:internal/streams/readable:390:5)
    at Pipe.onStreamRead (node:internal/stream_base_commons:191:23)
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
Sunday, June 9, 2024 12:33:45 PM
warning: in the working copy of 'src/main.ts', LF will be replaced by CRLF the next time Git touches it
Sunday, June 9, 2024 12:33:45 PM
[main edcd1d6] build application
 1 file changed, 1 insertion(+), 1 deletion(-)
Sunday, June 9, 2024 12:33:45 PM
From github.com:fromnepal/fromnepal.github.io
 * branch            main       -> FETCH_HEAD
Current branch main is up to date.
Sunday, June 9, 2024 12:33:46 PM
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 16 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 433 bytes | 433.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:fromnepal/fromnepal.github.io.git
   12890ae..edcd1d6  main -> main
Sunday, June 9, 2024 12:33:47 PM
```