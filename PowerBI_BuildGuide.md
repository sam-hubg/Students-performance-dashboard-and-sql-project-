# 📊 Power BI Project: Student Performance Analytics
**Build Guide for BCA Students**

---

## 🗂️ Dataset Overview

**File:** `StudentPerformance.xlsx` — Sheet: `Student_Data`

| Column | Description |
|---|---|
| Student_ID | Unique ID (S1001–S1050) |
| Name, Gender, Age, City | Demographics |
| Math, Science, English, Hindi, Computer | Subject marks (0–100) |
| Total | Sum of all 5 subjects |
| Percentage | Total / 500 × 100 |
| Grade | A+, A, B, C, D, F |
| Attendance_% | School attendance |
| Study_Hours_Per_Day | Daily study time |
| Parent_Education | Primary / Secondary / Graduate / Post-Graduate |
| Internet_Access | Yes / No |
| Extra_Coaching | Yes / No |
| Pass_Fail | Pass if Percentage ≥ 33 |

---

## 🚀 Step 1: Load Data into Power BI

1. Open **Power BI Desktop**
2. Click **Home → Get Data → Excel Workbook**
3. Browse and select `StudentPerformance.xlsx`
4. In Navigator, check **Student_Data** and **Summary**, then click **Transform Data**

---

## 🔧 Step 2: Power Query Cleanup

In the **Power Query Editor:**

1. Verify column data types:
   - Math, Science, English, Hindi, Computer → **Decimal Number**
   - Percentage → **Decimal Number**
   - Attendance_% → **Decimal Number**
   - Gender, City, Grade, Pass_Fail → **Text**
2. Check for **null values** in mark columns (replace with 0 if any)
3. Click **Close & Apply**

---

## 📐 Step 3: Create DAX Measures

Go to **Home → New Measure** and create these:

```dax
Total Students = COUNTROWS(Student_Data)

Pass Count = COUNTROWS(FILTER(Student_Data, Student_Data[Pass_Fail] = "Pass"))

Pass Rate % = DIVIDE([Pass Count], [Total Students]) * 100

Avg Percentage = AVERAGE(Student_Data[Percentage])

Avg Study Hours = AVERAGE(Student_Data[Study_Hours_Per_Day])

Top Scorer = MAX(Student_Data[Percentage])

Avg Attendance = AVERAGE(Student_Data[Attendance_%])
```

---

## 🎨 Step 4: Build the Report — Page by Page

### 📄 Page 1: Overview Dashboard

| Visual | Fields | Purpose |
|---|---|---|
| Card | Total Students | Quick KPI |
| Card | Pass Rate % | Quick KPI |
| Card | Avg Percentage | Quick KPI |
| Donut Chart | Pass_Fail (count) | Pass vs Fail ratio |
| Bar Chart | City vs Avg Percentage | City-wise performance |
| Slicer | Gender | Filter by gender |

> **Tip:** Use **Card visuals** at the top row for KPIs — clean and professional.

---

### 📄 Page 2: Subject Analysis

| Visual | Fields | Purpose |
|---|---|---|
| Clustered Bar Chart | Subject columns (Math, Sci, Eng...) averaged | Compare subjects |
| Scatter Plot | Study_Hours_Per_Day vs Percentage | Correlation |
| Matrix / Table | Grade (rows) × Subject avg (values) | Grade-wise breakdown |
| Slicer | City, Gender | Filters |

> **Tip:** To average multiple subjects in a bar chart, use **New Column:**
```dax
Avg Subject Score = (Student_Data[Math] + Student_Data[Science] + Student_Data[English] + Student_Data[Hindi] + Student_Data[Computer]) / 5
```

---

### 📄 Page 3: Factors Affecting Performance

| Visual | Fields | Purpose |
|---|---|---|
| Grouped Bar Chart | Internet_Access vs Avg Percentage | Internet impact |
| Grouped Bar Chart | Extra_Coaching vs Avg Percentage | Coaching impact |
| Bar Chart | Parent_Education vs Avg Percentage | Family education impact |
| Scatter Plot | Attendance_% vs Percentage | Attendance vs score |
| Slicer | Pass_Fail | Filter passers vs failers |

---

### 📄 Page 4: Grade Distribution

| Visual | Fields | Purpose |
|---|---|---|
| Funnel Chart | Grade (A+ → F) with count | Grade funnel |
| Pie Chart | Gender split per Grade | Gender in each grade |
| Bar Chart | City vs Grade count | City performance |
| Table | Name, Percentage, Grade, City | Top/Bottom students |

> **Tip:** Sort the Grade column manually: A+ > A > B > C > D > F

---

## 🎨 Step 5: Formatting Tips

- **Theme:** Use a consistent theme — go to **View → Themes → Colorblind Safe** or pick a custom blue/white theme
- **Report Title:** Insert a **Text Box** at the top of each page as a title
- **Consistent colors:** Assign Pass = Green, Fail = Red in all charts
- **Background:** Light grey (#F5F5F5) looks professional
- **Page Navigation:** Add **Buttons** (Insert → Buttons → Page Navigator) for easy navigation

---

## 💡 Bonus Ideas to Impress

1. **Top 10 Students table** — Filter by Top N using visual-level filter
2. **Conditional formatting** in Table visual — Red for low scorers, Green for high
3. **Drill-through page** — Click on a city → see only that city's students
4. **Q&A visual** — Add a text box where viewers can ask questions like *"average marks by city"*
5. **Mobile Layout** — Go to View → Mobile Layout to make it phone-friendly

---

## 📁 Final File Structure

```
📁 PowerBI_Project/
├── StudentPerformance.xlsx   ← Data source
├── StudentAnalytics.pbix     ← Your Power BI file
└── PowerBI_BuildGuide.md     ← This guide
```

---

## ✅ Checklist Before Submission

- [ ] Data loaded correctly with no errors
- [ ] All 4 pages built
- [ ] At least 5 DAX measures created
- [ ] Slicers working on all pages
- [ ] Consistent color theme applied
- [ ] Title on each page
- [ ] Report saved as `.pbix`

---

*Dataset contains 50 students from UP cities with realistic marks, attendance, and demographic data.*
