# Instructor Live Demonstration Walkthrough
## RELS 398.10 / ENGL 398.10 · Lesson 10.1 (Tuesday, November 10, 2026)
**Location:** Mulroney Hall 3032 &middot; **Time:** 8:30 – 9:20 AM (50 minutes)  
**Music:** The Band, "The Weight" (1968) playing before minute 0  

---

## Classroom Schedule & Execution Protocol

### 08:30 – 08:36 (6 mins) · Framing: From Solitary Editor to Community
- **Pedagogical Springboard:** *"For nine weeks, you carried your primary witness entirely alone on your laptop. Today, we put your work onto GitHub and learn to share the editorial weight as a community."*
- **Milestone Overview:** Slide 3. Nine accumulated layers (teiHeader, facsimiles, diplomatic text, AI reconciliation, regularization, stylesheets, lemmatization, named entities).
- **Remembrance Day Notice:** University closed Wednesday, Nov 11. Week 10 is a two-meeting consolidation milestone.

---

### 08:36 – 08:46 (10 mins) · Phase 2: Live Demo — Remotes, Branches, and PR Apparatus

1. **Verify Remote Configuration on Projector:**
   Open terminal in VS Code:
   ```bash
   git status
   git remote -v
   ```
   *Explain that `origin` points to your personal repository anchor on GitHub.*

2. **Create a Feature Branch:**
   ```bash
   git checkout -b feature/date-audit
   ```
   *Emphasize Slide 9: Never commit experimental draft markup directly to `main`. Isolating work on temporary feature branches keeps production clean.*

3. **Make an Evidentiary Editorial Edit:**
   Open `witness.xml` to line 65 (the letter date). Explain that an editor examines the postmark and heading, questioning whether the numeral is 13 or 15:
   Change line 65 from:
   ```xml
   <date when="1967-02-13">Feb 13</date><lb/>
   ```
   to:
   ```xml
   <date when="1967-02-15" cert="medium">Feb 15?</date><lb/>
   ```

4. **Verify Syntax and Commit:**
   ```bash
   xmllint --noout witness.xml
   git add witness.xml
   git commit -m "Propose date audit: February 15 with medium certainty based on postmark"
   ```

5. **Push Feature Branch to GitHub:**
   ```bash
   git push -u origin feature/date-audit
   ```

6. **Open Pull Request on GitHub (Projector):**
   - Switch to browser (`https://github.com/kmpenner/rels-398-demo`).
   - Click **Compare & pull request**.
   - Show how `.github/PULL_REQUEST_TEMPLATE.md` automatically populates the description.
   - Show the **Split Diff View** (Slide 12).
   - Show how to add an **Inline Comment** (Slide 13) questioning the reading.

---

### 08:46 – 08:56 (10 mins) · Phase 3: Lab A — Student Remote Setup & PR
- Students configure their remotes and create their feature branch (`feature/french-entities`, `feature/maud-lewis-dates`, `feature/treaty-places`).
- Circulate in MULH 3032 to assist Ace, Olyvia, and Andromeda.

---

### 08:56 – 09:12 (16 mins) · Phase 4: Lab B — Controlled Conflict Simulation

1. **Simulate a Concurrent Editorial Edit on `main`:**
   In terminal:
   ```bash
   git checkout main
   ```
   Explain: *"While our pull request was under review, another scholar verified the Kinnear archival catalog and committed a confirmation on `main`."*
   
   Edit line 65 on `main` to add calendar and respondent metadata:
   ```xml
   <date when="1967-02-13" resp="#editor">Feb 13</date><lb/>
   ```
   Commit on `main`:
   ```bash
   xmllint --noout witness.xml
   git add witness.xml
   git commit -m "Confirm letter date as 1967-02-13 per Kinnear catalog records"
   ```

2. **Trigger the Merge Conflict:**
   Attempt to merge the feature branch into `main`:
   ```bash
   git merge feature/date-audit
   ```
   **Expected Terminal Output:**
   ```text
   Auto-merging witness.xml
   CONFLICT (content): Merge conflict in witness.xml
   Automatic merge failed; fix conflicts and then commit the result.
   ```

3. **Inspect Conflict in VS Code (Slide 14):**
   Open `witness.xml`. Show the class the conflict markers:
   ```xml
   <<<<<<< HEAD
             <date when="1967-02-13" resp="#editor">Feb 13</date><lb/>
   =======
             <date when="1967-02-15" cert="medium">Feb 15?</date><lb/>
   >>>>>>> feature/date-audit
   ```

4. **Execute the Editorial Synthesis Move:**
   Explain: *"Do not blindly click 'Accept Current' or 'Accept Incoming'. Scholarly editing requires synthesizing both contributions."*
   
   Combine both readings into an authoritative consensus:
   ```xml
             <date when="1967-02-13" cert="medium" resp="#editor">Feb 13</date><lb/>
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
   git commit -m "Merge branch 'feature/date-audit': synthesize date attributes"
   git push origin main
   ```

2. **Delete the Feature Branch:**
   ```bash
   git branch -d feature/date-audit
   git push origin --delete feature/date-audit
   ```

3. **Friday Preview (Meeting #27 · Continuous Integration & Peer Review):**
   - Preview `.github/workflows/validate.yml`.
   - Explain how GitHub Actions will automatically run `xmllint` and `msdesc.rng` on every push so no broken XML ever slips into production.
   - Remind students: Assignment Module 10 is due Friday, Nov 13, at 11:00 PM.

---

## Emergency Reset Script

To practice the demonstration or reset the repository to its pristine starting baseline:
```bash
./reset_demo.sh
```
