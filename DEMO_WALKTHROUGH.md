# Instructor Live Demonstration Walkthrough
## RELS 398.10 / ENGL 398.10 · Lesson 10.1 (Tuesday, November 10, 2026)
**Location:** Mulroney Hall 3032 &middot; **Time:** 8:30 – 9:20 AM (50 minutes)  
**Music:** The Band, "The Weight" (1968) playing before minute 0  
**Witness:** Ace Long's Edition — Louis XVI Address to the Assemblée Nationale (31 December 1791, BL Zweig MS 169)  

---

## Classroom Schedule & Execution Protocol

### 08:30 – 08:36 (6 mins) · Framing: From Solitary Editor to Community
- **Pedagogical Springboard:** *"For nine weeks, you carried your primary witness entirely alone on your laptop. Today, we put your work onto GitHub and learn to share the editorial weight as a community."*
- **Milestone Overview:** Slide 3. Nine accumulated layers (`teiHeader`, BL IIIF facsimile, diplomatic transcription, AI reconciliation, regularization, stylesheets, lemmatization, and named entities).
- **Remembrance Day Notice:** University closed Wednesday, Nov 11. Week 10 is a two-meeting consolidation milestone.

---

### 08:36 – 08:46 (10 mins) · Phase 2: Live Demo — Remotes, Branches, and PR Apparatus

1. **Fork & Verify Remote Configuration (Projector):**
   - Have Ace fork `https://github.com/kmpenner/rels-398-demo` on GitHub and clone his fork, OR run in your demo terminal:
   ```bash
   git status
   git remote -v
   ```
   *(On Ace's clone: `git remote add upstream https://github.com/kmpenner/rels-398-demo.git`)*

2. **Create a Feature Branch:**
   ```bash
   git checkout -b feature/french-entities
   ```
   *Emphasize Slide 9: Never commit experimental draft markup directly to `main`. Isolating work on temporary feature branches keeps production clean.*

3. **Make a Draft Editorial Edit on Line 113 (`<orgName>`):**
   Open `witness.xml` to line 113 (`Assemblee Nationale`). Simulate an early collaborator drafting entity markup by adding `type="legislature"` while mistakenly linking to the older Constituent Assembly (`wikidata:Q876424`):
   Change line 113 from:
   ```xml
            l'<orgName ref="wikidata:Q780457"><choice><orig>Assemblee</orig><reg resp="#editor">Assemblée</reg></choice> Nationale</orgName>
   ```
   to:
   ```xml
            l'<orgName ref="wikidata:Q876424" type="legislature"><choice><orig>Assemblee</orig><reg resp="#editor">Assemblée</reg></choice> Nationale</orgName>
   ```

4. **Verify Syntax and Commit:**
   ```bash
   xmllint --noout witness.xml
   git add witness.xml
   git commit -m "Propose National Assembly type classification and Wikidata reference"
   ```

5. **Push Feature Branch to GitHub:**
   ```bash
   git push -u origin feature/french-entities
   ```

6. **Open Pull Request on GitHub (Projector):**
   - Switch to browser (`https://github.com/kmpenner/rels-398-demo` or Ace's fork -> PR to upstream).
   - Click **Compare & pull request**.
   - Show how `.github/PULL_REQUEST_TEMPLATE.md` automatically populates the description.
   - Show **Split Diff View** (Slide 12).
   - Add an **Inline Review Comment** on line 113 (Slide 13):
     *"Look at line 115: `31 xbre 1791` means 31 December 1791 (not October!). By Dec 31, the Constituent Assembly (`Q876424`) had dissolved; this should point to Legislative Assembly (`Q780457`)."*

---

### 08:46 – 08:56 (10 mins) · Phase 3: Lab A — Remote Setup & PR
- Verify Ace's fork (`origin`) and `upstream` connection in VS Code terminal (`git remote -v`).
- Confirm Ace has created `feature/french-entities` and opened a Pull Request on GitHub.

---

### 08:56 – 09:12 (16 mins) · Phase 4: Lab B — Controlled Conflict Simulation

1. **Simulate a Concurrent Editorial Confirmation on `main`:**
   In terminal:
   ```bash
   git checkout main
   ```
   Explain: *"Meanwhile on `main`, an archival verifier checked `decree.jpg`, confirmed the `xbre` = December date, and added certainty metadata to the Legislative Assembly (`Q780457`)."*
   
   Edit line 113 on `main` to add `@cert` and `@resp`:
   ```xml
            l'<orgName ref="wikidata:Q780457" cert="high" resp="#editor"><choice><orig>Assemblee</orig><reg resp="#editor">Assemblée</reg></choice> Nationale</orgName>
   ```
   Commit on `main`:
   ```bash
   xmllint --noout witness.xml
   git add witness.xml
   git commit -m "Confirm Legislative Assembly (Q780457) for 31 December 1791 decree"
   ```

2. **Trigger the Merge Conflict:**
   Attempt to merge the feature branch into `main`:
   ```bash
   git merge feature/french-entities
   ```
   **Expected Terminal Output:**
   ```text
   Auto-merging witness.xml
   CONFLICT (content): Merge conflict in witness.xml
   Automatic merge failed; fix conflicts and then commit the result.
   ```

3. **Inspect Conflict in VS Code (Slide 14):**
   Open `witness.xml`. Show the conflict markers around line 113:
   ```xml
   <<<<<<< HEAD
            l'<orgName ref="wikidata:Q780457" cert="high" resp="#editor"><choice><orig>Assemblee</orig><reg resp="#editor">Assemblée</reg></choice> Nationale</orgName>
   =======
            l'<orgName ref="wikidata:Q876424" type="legislature"><choice><orig>Assemblee</orig><reg resp="#editor">Assemblée</reg></choice> Nationale</orgName>
   >>>>>>> feature/french-entities
   ```

4. **Execute the Editorial Synthesis Move:**
   Explain: *"Do not blindly click 'Accept Current' or 'Accept Incoming'. Keep the verified Legislative Assembly link (`wikidata:Q780457`) and `@cert/@resp` from `HEAD`, AND synthesize the helpful `@type=\"legislature\"` contribution from `feature/french-entities`."*
   
   Replace the conflict block with:
   ```xml
            l'<orgName ref="wikidata:Q780457" type="legislature" cert="high" resp="#editor"><choice><orig>Assemblee</orig><reg resp="#editor">Assemblée</reg></choice> Nationale</orgName>
   ```
   Delete all marker lines (`<<<<<<<`, `=======`, `>>>>>>>`).

5. **Mandatory Syntax Gate:**
   Run in terminal:
   ```bash
   xmllint --noout witness.xml
   ```
   *Point out that exit code 0 is silent. If even a single marker character survived, `xmllint` crashes with an error.*

---

### 09:12 – 09:20 (8 mins) · Phase 5: Synthesis & Friday Preview

1. **Record the Merge Commit (Slide 15):**
   ```bash
   git add witness.xml
   git commit -m "Merge branch 'feature/french-entities': synthesize assembly markup"
   git push origin main
   ```

2. **Delete the Feature Branch:**
   ```bash
   git branch -d feature/french-entities
   git push origin --delete feature/french-entities
   ```

3. **Workshop 10 Deliverable & Friday Preview (Meeting #27):**
   - Remind Ace of `CONSOLIDATION.md`: record `git log -1` merge commit hash, paste `xmllint --noout` output, and write a 100–150 word explanation citing `decree.jpg` (`31 xbre 1791`).
   - Preview `.github/workflows/validate.yml` for Friday's GitHub Actions CI/CD session.

---

## Emergency Reset Script

To practice the demonstration or reset the repository to its pristine starting baseline:
```bash
./reset_demo.sh
```
