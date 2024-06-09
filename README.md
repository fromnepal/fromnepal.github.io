

```powershell
cd "C:\Users\kushal\src\myhtml\fromnepal"; date; yarn; date; yarn run build; date; git add .; date; git commit --message "build application" --message "from the terminal"; date; git pull --rebase origin main; date; git push origin main; date;

Sunday, June 9, 2024 12:35:02 PM
yarn install v1.22.21
[1/4] Resolving packages...
success Already up-to-date.
Done in 0.08s.
Sunday, June 9, 2024 12:35:03 PM
yarn run v1.22.21
$ tsc && vite build
vite v5.2.13 building for production...
✓ 5 modules transformed.
docs/index.html                 0.46 kB │ gzip: 0.29 kB
docs/assets/index-DYhv0y2B.css  4.60 kB │ gzip: 1.63 kB
docs/assets/index-Babnjjpt.js   3.81 kB │ gzip: 1.68 kB
✓ built in 82ms
Done in 0.82s.
Sunday, June 9, 2024 12:35:04 PM
warning: in the working copy of 'src/main.ts', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'docs/assets/index-Babnjjpt.js', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'docs/assets/index-DYhv0y2B.css', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'docs/index.html', LF will be replaced by CRLF the next time Git touches it
Sunday, June 9, 2024 12:35:04 PM
[main 9615570] build application
 4 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 docs/assets/index-Babnjjpt.js
 create mode 100644 docs/assets/index-DYhv0y2B.css
 create mode 100644 docs/index.html
Sunday, June 9, 2024 12:35:04 PM
From github.com:fromnepal/fromnepal.github.io
 * branch            main       -> FETCH_HEAD
Current branch main is up to date.
Sunday, June 9, 2024 12:35:04 PM
Enumerating objects: 13, done.
Counting objects: 100% (13/13), done.
Delta compression using up to 16 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (9/9), 3.39 KiB | 3.39 MiB/s, done.
Total 9 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (3/3), completed with 2 local objects.
To github.com:fromnepal/fromnepal.github.io.git
   6bbdd8e..9615570  main -> main
Sunday, June 9, 2024 12:35:05 PM
```