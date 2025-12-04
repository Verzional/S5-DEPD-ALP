// lib/data/dummy_data.dart

import '../model/job_model.dart';
import '../model/user_model.dart';
import '../model/application_model.dart';
import '../model/category_model.dart';
import '../model/favorite_model.dart';

List<CategoryModel> dummyCategories = [
  CategoryModel(id: "c1", name: "Technology"),
  CategoryModel(id: "c2", name: "Marketing"),
  CategoryModel(id: "c3", name: "Finance"),
  CategoryModel(id: "c4", name: "Design"),
  CategoryModel(id: "c5", name: "Human Resource"),
  CategoryModel(id: "c6", name: "Operations"),
  CategoryModel(id: "c7", name: "Data & Analytics"),
  CategoryModel(id: "c8", name: "Product Management"),
  CategoryModel(id: "c9", name: "Content & Media"),
  CategoryModel(id: "c10", name: "Supply Chain & Logistics"),
  CategoryModel(id: "c11", name: "Legal & Compliance"),
  CategoryModel(id: "c12", name: "Customer Service"),
  CategoryModel(id: "c13", name: "Cloud & Infrastructure"),
  CategoryModel(id: "c14", name: "Business & Strategy"),
  CategoryModel(id: "c15", name: "Creative & Multimedia"),
];

// DUMMY DATA JOBS
List<JobModel> dummyJobs = [
  JobModel(
    id: "1",
    title: "Front-end Developer",
    companyName: "Metrodata Indonesia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Surabaya, Indonesia",
    type: "Intern (Remote)",
    salaryRange: "Rp 3.000.000 - Rp 7.000.000",
    category: ["Technology", "Internship", "Remote"],
    description:
        "This internship role provides hands-on experience in developing modern user interfaces. You will collaborate with the development team to implement scalable and responsive frontend components.",
    responsibilities: [
      "Develop and implement responsive UI components.",
      "Collaborate with backend teams for API integration.",
      "Optimize website performance and ensure cross-browser compatibility.",
      "Participate in code reviews and maintain project standards.",
    ],
    qualifications: [
      "Understanding of HTML, CSS, and JavaScript.",
      "Basic experience with Flutter or any frontend framework.",
      "Strong eagerness to learn and adapt to new technologies.",
      "Ability to work effectively in a remote environment.",
    ],
    benefits: [
      "Remote working flexibility.",
      "Mentorship from senior developers.",
      "Internship certificate.",
      "Opportunity for full-time conversion.",
    ],
  ),

  JobModel(
    id: "2",
    title: "Marketing Intern",
    companyName: "Tokopedia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/07/Tokopedia_logo.png?20191126104103",
    location: "Jakarta, Indonesia",
    type: "Part Time (Onsite)",
    salaryRange: "Rp 2.500.000 - Rp 4.500.000",
    category: ["Marketing", "Internship", "Onsite"],
    description:
        "This role supports Tokopedia’s marketing operations by assisting in campaign execution, research, and content preparation for various digital marketing initiatives.",
    responsibilities: [
      "Assist in planning and executing marketing campaigns.",
      "Conduct market and competitor research.",
      "Prepare reports and analyze campaign performance.",
      "Support coordination between internal marketing teams.",
    ],
    qualifications: [
      "Student or recent graduate in Marketing or related fields.",
      "Strong communication and analytical skills.",
      "Familiarity with digital marketing concepts.",
      "Ability to work onsite in a collaborative environment.",
    ],
    benefits: [
      "Exposure to large-scale marketing operations.",
      "Mentorship from marketing professionals.",
      "Lunch allowance.",
      "Internship certificate and career development support.",
    ],
  ),

  JobModel(
    id: "3",
    title: "Finance Intern",
    companyName: "Gojek",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Gojek_logo_2019.svg/1200px-Gojek_logo_2019.svg.png",
    location: "Jakarta, Indonesia",
    type: "Intern (Onsite)",
    salaryRange: "Rp 4.000.000 - Rp 6.000.000",
    category: ["Finance", "Internship", "Onsite"],
    description:
        "This role offers direct exposure to financial operations in one of Indonesia’s leading tech companies, supporting daily finance activities and financial documentation.",
    responsibilities: [
      "Assist in preparing financial statements and documentation.",
      "Support daily reconciliation tasks.",
      "Analyze financial data and detect discrepancies.",
      "Organize and maintain financial records according to standards.",
    ],
    qualifications: [
      "Student or fresh graduate in Accounting/Finance.",
      "Proficiency in Microsoft Excel.",
      "Strong analytical and detail-oriented mindset.",
      "Ability to work onsite in a fast-paced environment.",
    ],
    benefits: [
      "Professional mentorship from finance teams.",
      "Meal and transportation allowance.",
      "Certificate of completion.",
      "Opportunities for extension or full-time position.",
    ],
  ),

  JobModel(
    id: "4",
    title: "Social Media Freelance",
    companyName: "Shopee",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Shopee.svg/1200px-Shopee.svg.png",
    location: "Malang, Indonesia",
    type: "Freelance (Hybrid)",
    salaryRange: "Rp 1.500.000 - Rp 3.000.000",
    category: ["Marketing", "Content & Media", "Freelance", "Hybrid"],
    description:
        "This freelance role involves creating and managing social media content to boost Shopee's online presence and support ongoing digital campaigns.",
    responsibilities: [
      "Create engaging and market-relevant social media content.",
      "Monitor social media trends and adjust content strategy.",
      "Assist in planning and launching online campaigns.",
      "Track content performance and prepare reports.",
    ],
    qualifications: [
      "Experience in social media content creation.",
      "Understanding of TikTok, Instagram, and platform trends.",
      "Creative mindset and basic copywriting skills.",
      "Ability to work hybrid with good time management.",
    ],
    benefits: [
      "Flexible work schedule.",
      "Access to Shopee’s content tools.",
      "Networking with Shopee's creative teams.",
      "Potential contract renewal.",
    ],
  ),
  JobModel(
    id: "6",
    title: "UI/UX Designer",
    companyName: "Bukalapak",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/5/5b/Bukalapak_logo.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time (Onsite)",
    salaryRange: "Rp 6.000.000 - Rp 10.000.000",
    category: ["Design", "Creative & Multimedia", "Onsite"],
    description:
        "Responsible for designing user-friendly interfaces and experiences for Bukalapak’s e-commerce platform.",
    responsibilities: [
      "Design UI components and prototypes.",
      "Conduct user research and testing.",
      "Collaborate with product and development teams.",
      "Ensure design consistency across products.",
    ],
    qualifications: [
      "Proficient with Figma, Sketch, or Adobe XD.",
      "Portfolio of design projects.",
      "Understanding of UX principles and best practices.",
      "Good communication skills.",
    ],
    benefits: [
      "Health insurance.",
      "Flexible working hours.",
      "Career growth opportunities.",
    ],
  ),

  JobModel(
    id: "7",
    title: "HR Intern",
    companyName: "Traveloka",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/en/thumb/6/6d/Traveloka_Logo.svg/1200px-Traveloka_Logo.svg.png",
    location: "Bandung, Indonesia",
    type: "Intern (Onsite)",
    salaryRange: "Rp 3.000.000 - Rp 5.000.000",
    category: ["Human Resource", "Internship", "Onsite"],
    description:
        "Support the HR team in recruitment, onboarding, and administrative tasks.",
    responsibilities: [
      "Assist in recruitment process and screening resumes.",
      "Support employee onboarding activities.",
      "Maintain HR documentation and records.",
      "Assist in employee engagement programs.",
    ],
    qualifications: [
      "Student or recent graduate in HR or related fields.",
      "Good communication and organizational skills.",
      "Proficient with Microsoft Office.",
    ],
    benefits: [
      "Mentorship from HR professionals.",
      "Networking opportunities.",
      "Internship certificate.",
    ],
  ),

  JobModel(
    id: "8",
    title: "Operations Executive",
    companyName: "Gojek",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/8/82/Gojek_logo_2019.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 8.000.000 - Rp 12.000.000",
    category: ["Operations", "Business & Strategy"],
    description:
        "Manage and optimize Gojek’s operational processes to ensure smooth service delivery.",
    responsibilities: [
      "Monitor daily operations and KPIs.",
      "Identify process improvements and implement solutions.",
      "Coordinate with cross-functional teams.",
      "Prepare operational reports for management.",
    ],
    qualifications: [
      "Bachelor’s degree in Business, Operations, or related fields.",
      "Analytical and problem-solving skills.",
      "Strong organizational and multitasking abilities.",
    ],
    benefits: [
      "Health and wellness programs.",
      "Professional development.",
      "Performance bonus.",
    ],
  ),

  JobModel(
    id: "9",
    title: "Data Analyst",
    companyName: "OVO",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/3/32/OVO_Indonesia_Logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 7.000.000 - Rp 11.000.000",
    category: ["Data & Analytics", "Finance"],
    description:
        "Analyze and interpret financial and transactional data to provide insights for business decisions.",
    responsibilities: [
      "Collect and analyze large datasets.",
      "Prepare reports and dashboards.",
      "Support decision-making with data-driven insights.",
      "Work with cross-functional teams to understand business needs.",
    ],
    qualifications: [
      "Bachelor’s degree in Statistics, Math, or related field.",
      "Experience with SQL, Excel, and BI tools.",
      "Strong analytical mindset.",
    ],
    benefits: [
      "Health insurance.",
      "Professional training.",
      "Flexible working hours.",
    ],
  ),

  JobModel(
    id: "10",
    title: "Product Manager",
    companyName: "Tokopedia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/07/Tokopedia_logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 12.000.000 - Rp 18.000.000",
    category: ["Product Management", "Business & Strategy"],
    description:
        "Lead product development cycles, coordinate teams, and ensure products meet market needs.",
    responsibilities: [
      "Define product roadmap and strategy.",
      "Coordinate with design, engineering, and marketing teams.",
      "Analyze user feedback and market trends.",
      "Ensure timely delivery of product releases.",
    ],
    qualifications: [
      "Experience in product management.",
      "Good communication and leadership skills.",
      "Ability to analyze market and user data.",
    ],
    benefits: [
      "Health insurance.",
      "Performance bonus.",
      "Career growth opportunities.",
    ],
  ),

  JobModel(
    id: "11",
    title: "Legal Associate",
    companyName: "Traveloka",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/en/thumb/6/6d/Traveloka_Logo.svg/1200px-Traveloka_Logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 10.000.000 - Rp 15.000.000",
    category: ["Legal & Compliance", "Business & Strategy"],
    description:
        "Provide legal support to ensure compliance and mitigate business risks.",
    responsibilities: [
      "Draft and review contracts and agreements.",
      "Ensure company policies comply with regulations.",
      "Advise on legal matters affecting business operations.",
      "Coordinate with external legal counsel when necessary.",
    ],
    qualifications: [
      "Bachelor’s degree in Law.",
      "Understanding of corporate law.",
      "Strong analytical and communication skills.",
    ],
    benefits: [
      "Health insurance.",
      "Professional development opportunities.",
      "Legal certification support.",
    ],
  ),

  JobModel(
    id: "12",
    title: "Cloud Engineer",
    companyName: "Gojek",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/8/82/Gojek_logo_2019.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 12.000.000 - Rp 20.000.000",
    category: ["Cloud & Infrastructure", "Technology"],
    description:
        "Design, implement, and maintain cloud infrastructure to ensure scalability and reliability.",
    responsibilities: [
      "Deploy and manage cloud resources.",
      "Ensure system reliability and scalability.",
      "Monitor performance and troubleshoot issues.",
      "Collaborate with development and operations teams.",
    ],
    qualifications: [
      "Experience with AWS, Azure, or GCP.",
      "Strong scripting and automation skills.",
      "Understanding of CI/CD pipelines.",
    ],
    benefits: [
      "Health insurance.",
      "Flexible working environment.",
      "Professional certifications support.",
    ],
  ),

  JobModel(
    id: "13",
    title: "Content Writer",
    companyName: "Shopee",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Shopee.svg/1200px-Shopee.svg.png",
    location: "Jakarta, Indonesia",
    type: "Part Time (Remote)",
    salaryRange: "Rp 3.000.000 - Rp 5.000.000",
    category: ["Content & Media", "Marketing", "Remote"],
    description:
        "Create engaging content for Shopee’s website and social media channels.",
    responsibilities: [
      "Write and edit articles and product descriptions.",
      "Collaborate with marketing teams on campaigns.",
      "Ensure SEO best practices.",
      "Research trending topics for content ideas.",
    ],
    qualifications: [
      "Excellent writing and editing skills.",
      "Understanding of SEO and digital marketing.",
      "Ability to work remotely with good self-discipline.",
    ],
    benefits: [
      "Flexible working schedule.",
      "Work remotely from anywhere.",
      "Networking opportunities.",
    ],
  ),

  JobModel(
    id: "14",
    title: "Supply Chain Analyst",
    companyName: "Unilever Indonesia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/0b/Unilever.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 8.000.000 - Rp 13.000.000",
    category: ["Supply Chain & Logistics", "Data & Analytics"],
    description:
        "Analyze supply chain processes to optimize efficiency and reduce costs.",
    responsibilities: [
      "Collect and analyze supply chain data.",
      "Identify areas for operational improvement.",
      "Prepare reports and dashboards for management.",
      "Collaborate with procurement and operations teams.",
    ],
    qualifications: [
      "Bachelor’s degree in Supply Chain, Logistics, or related field.",
      "Strong analytical and problem-solving skills.",
      "Proficient in Excel and data visualization tools.",
    ],
    benefits: [
      "Health insurance.",
      "Professional development programs.",
      "Performance bonus.",
    ],
  ),

  JobModel(
    id: "15",
    title: "Creative Multimedia Specialist",
    companyName: "KapanLagi Youniverse",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/5/57/KapanLagi_Youniverse_logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 7.000.000 - Rp 12.000.000",
    category: ["Creative & Multimedia", "Content & Media"],
    description:
        "Produce multimedia content including video, graphics, and animations for digital platforms.",
    responsibilities: [
      "Create multimedia assets for campaigns and projects.",
      "Collaborate with marketing and content teams.",
      "Edit videos and design graphics according to brand guidelines.",
      "Manage multimedia content library.",
    ],
    qualifications: [
      "Experience in video editing, animation, or graphic design.",
      "Proficiency in Adobe Creative Suite or similar tools.",
      "Creative thinking and teamwork skills.",
    ],
    benefits: [
      "Health insurance.",
      "Professional growth opportunities.",
      "Flexible working environment.",
    ],
  ),
  JobModel(
    id: "16",
    title: "Marketing Specialist",
    companyName: "Traveloka",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/en/thumb/6/6d/Traveloka_Logo.svg/1200px-Traveloka_Logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 6.000.000 - Rp 10.000.000",
    category: ["Marketing", "Business & Strategy"],
    description:
        "Plan and execute marketing campaigns to drive brand awareness and customer engagement.",
    responsibilities: [
      "Develop marketing strategies and campaigns.",
      "Analyze campaign performance and optimize results.",
      "Collaborate with creative teams for content creation.",
      "Conduct market research and competitor analysis.",
    ],
    qualifications: [
      "Bachelor’s degree in Marketing or related field.",
      "Experience in digital marketing.",
      "Strong analytical and communication skills.",
    ],
    benefits: [
      "Health insurance.",
      "Performance bonus.",
      "Flexible working hours.",
    ],
  ),

  JobModel(
    id: "17",
    title: "Customer Service Representative",
    companyName: "Shopee",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Shopee.svg/1200px-Shopee.svg.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 4.000.000 - Rp 6.000.000",
    category: ["Customer Service", "Operations"],
    description:
        "Provide excellent customer support via phone, chat, and email channels.",
    responsibilities: [
      "Respond to customer inquiries in a timely manner.",
      "Resolve complaints and provide solutions.",
      "Document and escalate complex issues.",
      "Maintain high customer satisfaction.",
    ],
    qualifications: [
      "Good communication and problem-solving skills.",
      "Familiarity with CRM tools.",
      "Customer-oriented mindset.",
    ],
    benefits: [
      "Health insurance.",
      "Incentive programs.",
      "Career development opportunities.",
    ],
  ),

  JobModel(
    id: "18",
    title: "Finance Analyst",
    companyName: "Gojek",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/8/82/Gojek_logo_2019.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 9.000.000 - Rp 14.000.000",
    category: ["Finance", "Data & Analytics"],
    description:
        "Analyze financial data, prepare reports, and support business decisions.",
    responsibilities: [
      "Perform financial analysis and forecasting.",
      "Monitor budget and expenses.",
      "Prepare financial reports for management.",
      "Collaborate with operations and accounting teams.",
    ],
    qualifications: [
      "Bachelor’s degree in Finance or Accounting.",
      "Proficiency in Excel and financial software.",
      "Analytical thinking and attention to detail.",
    ],
    benefits: [
      "Health insurance.",
      "Professional training.",
      "Performance bonus.",
    ],
  ),

  JobModel(
    id: "19",
    title: "Operations Manager",
    companyName: "Tokopedia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/07/Tokopedia_logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 15.000.000 - Rp 22.000.000",
    category: ["Operations", "Business & Strategy"],
    description:
        "Lead operational teams and optimize processes to enhance efficiency and productivity.",
    responsibilities: [
      "Manage day-to-day operations.",
      "Develop operational strategies.",
      "Monitor KPIs and process performance.",
      "Lead and mentor operational staff.",
    ],
    qualifications: [
      "Bachelor’s degree in Business or Operations.",
      "Leadership and project management skills.",
      "Strong problem-solving abilities.",
    ],
    benefits: [
      "Health insurance.",
      "Career development programs.",
      "Performance incentives.",
    ],
  ),

  JobModel(
    id: "20",
    title: "Product Designer",
    companyName: "Bukalapak",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/5/5b/Bukalapak_logo.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 8.000.000 - Rp 13.000.000",
    category: ["Design", "Product Management"],
    description:
        "Design intuitive and engaging product experiences across digital platforms.",
    responsibilities: [
      "Design UI/UX for web and mobile applications.",
      "Conduct user research and usability testing.",
      "Collaborate with product and engineering teams.",
      "Maintain design system and guidelines.",
    ],
    qualifications: [
      "Experience with Figma, Adobe XD, or Sketch.",
      "Strong portfolio demonstrating UX/UI design skills.",
      "Understanding of user-centered design principles.",
    ],
    benefits: [
      "Health insurance.",
      "Flexible working environment.",
      "Professional growth opportunities.",
    ],
  ),

  JobModel(
    id: "21",
    title: "Cloud Solutions Architect",
    companyName: "OVO",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/3/32/OVO_Indonesia_Logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 18.000.000 - Rp 25.000.000",
    category: ["Cloud & Infrastructure", "Technology", "Business & Strategy"],
    description:
        "Design and implement scalable cloud solutions to support business operations.",
    responsibilities: [
      "Design cloud architecture for applications and services.",
      "Ensure security, scalability, and reliability.",
      "Collaborate with engineering teams on cloud deployments.",
      "Provide technical guidance and documentation.",
    ],
    qualifications: [
      "Experience with AWS, Azure, or GCP.",
      "Strong understanding of cloud architecture patterns.",
      "Excellent communication and leadership skills.",
    ],
    benefits: [
      "Health insurance.",
      "Certification support.",
      "Flexible working environment.",
    ],
  ),

  JobModel(
    id: "22",
    title: "Content Strategist",
    companyName: "KapanLagi Youniverse",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/5/57/KapanLagi_Youniverse_logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 7.000.000 - Rp 11.000.000",
    category: ["Content & Media", "Marketing"],
    description:
        "Develop content strategies to engage audiences and grow digital presence.",
    responsibilities: [
      "Plan and execute content campaigns.",
      "Conduct audience research and analytics.",
      "Collaborate with writers, designers, and social media teams.",
      "Measure content performance and optimize strategies.",
    ],
    qualifications: [
      "Experience in content marketing.",
      "Strong analytical and creative skills.",
      "Good communication and collaboration abilities.",
    ],
    benefits: [
      "Health insurance.",
      "Flexible work environment.",
      "Professional development opportunities.",
    ],
  ),

  JobModel(
    id: "23",
    title: "Data Engineer",
    companyName: "Gojek",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/8/82/Gojek_logo_2019.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 12.000.000 - Rp 18.000.000",
    category: ["Data & Analytics", "Cloud & Infrastructure"],
    description:
        "Build and maintain data pipelines and infrastructure for analytics and business intelligence.",
    responsibilities: [
      "Design and implement data pipelines.",
      "Ensure data quality and reliability.",
      "Collaborate with data analysts and product teams.",
      "Optimize ETL processes for performance.",
    ],
    qualifications: [
      "Experience with SQL, Python, and data pipeline tools.",
      "Knowledge of cloud platforms like AWS or GCP.",
      "Problem-solving and analytical skills.",
    ],
    benefits: [
      "Health insurance.",
      "Certification support.",
      "Career growth opportunities.",
    ],
  ),

  JobModel(
    id: "24",
    title: "Legal Counsel",
    companyName: "Unilever Indonesia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/0b/Unilever.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 14.000.000 - Rp 20.000.000",
    category: ["Legal & Compliance", "Business & Strategy"],
    description:
        "Provide legal advice and support to business units ensuring regulatory compliance.",
    responsibilities: [
      "Draft, review, and negotiate contracts.",
      "Advise management on legal risks.",
      "Ensure compliance with local laws and regulations.",
      "Coordinate with external legal advisors.",
    ],
    qualifications: [
      "Bachelor’s degree in Law.",
      "Experience in corporate or commercial law.",
      "Strong communication and analytical skills.",
    ],
    benefits: [
      "Health insurance.",
      "Professional development.",
      "Legal certification support.",
    ],
  ),

  JobModel(
    id: "25",
    title: "Operations Coordinator",
    companyName: "Tokopedia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/07/Tokopedia_logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 7.000.000 - Rp 10.000.000",
    category: ["Operations", "Data & Analytics"],
    description:
        "Coordinate operational activities and support process improvements.",
    responsibilities: [
      "Assist in daily operational tasks.",
      "Monitor workflow efficiency and KPIs.",
      "Coordinate with cross-functional teams.",
      "Prepare reports and documentation.",
    ],
    qualifications: [
      "Bachelor’s degree in Business, Operations, or related field.",
      "Good organizational skills.",
      "Proficient with Excel and basic reporting tools.",
    ],
    benefits: [
      "Health insurance.",
      "Career development.",
      "Performance incentives.",
    ],
  ),

  JobModel(
    id: "26",
    title: "Digital Marketing Manager",
    companyName: "Bukalapak",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/5/5b/Bukalapak_logo.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 12.000.000 - Rp 20.000.000",
    category: ["Marketing", "Business & Strategy"],
    description:
        "Lead digital marketing campaigns to drive user acquisition and engagement.",
    responsibilities: [
      "Develop and manage online marketing campaigns.",
      "Analyze marketing performance metrics.",
      "Collaborate with creative and content teams.",
      "Optimize campaigns based on analytics.",
    ],
    qualifications: [
      "Experience in digital marketing and analytics.",
      "Strong leadership and communication skills.",
      "Proficient with digital marketing tools and platforms.",
    ],
    benefits: [
      "Health insurance.",
      "Performance bonus.",
      "Professional growth opportunities.",
    ],
  ),

  JobModel(
    id: "27",
    title: "Customer Success Manager",
    companyName: "OVO",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/3/32/OVO_Indonesia_Logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 10.000.000 - Rp 15.000.000",
    category: ["Customer Service", "Business & Strategy"],
    description:
        "Ensure customer satisfaction and drive retention through proactive support.",
    responsibilities: [
      "Manage key accounts and relationships.",
      "Identify opportunities for upselling or cross-selling.",
      "Analyze customer feedback and satisfaction metrics.",
      "Collaborate with product and support teams.",
    ],
    qualifications: [
      "Experience in customer success or account management.",
      "Excellent communication and problem-solving skills.",
      "Proficient with CRM tools.",
    ],
    benefits: [
      "Health insurance.",
      "Career growth opportunities.",
      "Performance bonus.",
    ],
  ),

  JobModel(
    id: "28",
    title: "Financial Controller",
    companyName: "Unilever Indonesia",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/0/0b/Unilever.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 18.000.000 - Rp 25.000.000",
    category: ["Finance", "Business & Strategy"],
    description:
        "Manage financial operations, budgets, and reporting to support business goals.",
    responsibilities: [
      "Prepare financial statements and reports.",
      "Monitor and control budget and expenses.",
      "Ensure compliance with financial regulations.",
      "Provide insights for strategic decision-making.",
    ],
    qualifications: [
      "Bachelor’s degree in Finance or Accounting.",
      "Experience in financial management.",
      "Strong analytical and leadership skills.",
    ],
    benefits: [
      "Health insurance.",
      "Performance bonus.",
      "Professional development opportunities.",
    ],
  ),

  JobModel(
    id: "29",
    title: "Operations Analyst",
    companyName: "Gojek",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/8/82/Gojek_logo_2019.svg",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 7.000.000 - Rp 11.000.000",
    category: ["Operations", "Data & Analytics"],
    description:
        "Analyze operations data to improve efficiency and service delivery.",
    responsibilities: [
      "Collect and analyze operational data.",
      "Identify bottlenecks and process improvements.",
      "Prepare reports for management.",
      "Collaborate with cross-functional teams to implement solutions.",
    ],
    qualifications: [
      "Bachelor’s degree in Business, Operations, or related field.",
      "Strong analytical and problem-solving skills.",
      "Proficient in Excel and reporting tools.",
    ],
    benefits: [
      "Health insurance.",
      "Performance incentives.",
      "Professional development opportunities.",
    ],
  ),

  JobModel(
    id: "30",
    title: "Creative Content Producer",
    companyName: "KapanLagi Youniverse",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/5/57/KapanLagi_Youniverse_logo.png",
    location: "Jakarta, Indonesia",
    type: "Full Time",
    salaryRange: "Rp 8.000.000 - Rp 13.000.000",
    category: ["Creative & Multimedia", "Content & Media"],
    description:
        "Produce high-quality multimedia content for campaigns and online platforms.",
    responsibilities: [
      "Create and edit videos, graphics, and animations.",
      "Collaborate with marketing and content teams.",
      "Ensure brand consistency in all content.",
      "Manage content production schedules.",
    ],
    qualifications: [
      "Experience with video editing and graphic design.",
      "Proficient in Adobe Creative Suite or similar tools.",
      "Strong creativity and teamwork skills.",
    ],
    benefits: [
      "Health insurance.",
      "Flexible working hours.",
      "Career development opportunities.",
    ],
  ),
];

// DUMMY USER (Mahasiswa)
final UserModel currentUser = UserModel(
  id: "user_001",
  name: "Stefanie Agahari",
  email: "stefanie.agahari@student.ciputra.ac.id",
  phoneNumber: "+62 812 3456 7890",
  major: "Informatics",
  semester: 5,
  photoUrl: "https://i.pravatar.cc/300?img=5",
  savedCvName: "Stefanie_Agahari_CV_2025.pdf",
  savedPortfolioName: "Stefanie_Agahari_Portofolio_2025.pdf",
);

// DUMMY APPLICATIONS (Lamaran Pekerjaan)
List<ApplicationModel> dummyApplications = [
  // Diterima
  ApplicationModel(
    id: "app_1",
    userId: "user_001",
    jobId: "2",
    jobTitle: "Social Media Freelance",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Diterima",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Wawancara", date: "15 Okt 2025", isCompleted: true),
      TimelineEvent(
        title: "Offering Letter",
        date: "18 Okt 2025",
        isCompleted: true,
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),

  // Ditinjau
  ApplicationModel(
    id: "app_2",
    userId: "user_001",
    jobId: "4",
    jobTitle: "Data Analyst",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Ditinjau",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "13 Okt 2025",
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_Data_CV.pdf",
  ),

  // Wawancara
  ApplicationModel(
    id: "app_3",
    userId: "user_002",
    jobId: "3",
    jobTitle: "Website Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Wawancara",
    cvFileName: "Stefanie_Agahari_CV_2025.pdf",
    portfolioFileName: "Stefanie_Agahari_Portofolio_2025.pdf",
    coverLetterFileName: "Stefanie_Agahari_Motivation_Letter.pdf",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "18 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Undangan Wawancara",
        date: "25 Oktober 2025",
        subtitle: "(Detail di email)",
        isActive: true,
        isCompleted: false,
      ),
    ],
  ),

  // Ditolak
  ApplicationModel(
    id: "app_4",
    userId: "user_001",
    jobId: "1",
    jobTitle: "Front-end Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 15 Oktober 2025",
    status: "Ditolak",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Tidak Lolos", date: "20 Okt 2025", isActive: true),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),
  ApplicationModel(
    id: "app_5",
    userId: "user_001",
    jobId: "2",
    jobTitle: "Social Media Freelance",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Diterima",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Wawancara", date: "15 Okt 2025", isCompleted: true),
      TimelineEvent(
        title: "Offering Letter",
        date: "18 Okt 2025",
        isCompleted: true,
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),

  // Ditinjau
  ApplicationModel(
    id: "app_6",
    userId: "user_001",
    jobId: "4",
    jobTitle: "Data Analyst",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Ditinjau",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "13 Okt 2025",
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_Data_CV.pdf",
  ),

  // Wawancara 
  ApplicationModel(
    id: "app_7",
    userId: "user_001",
    jobId: "3",
    jobTitle: "Website Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Wawancara",
    cvFileName: "Stefanie_Agahari_CV_2025.pdf",
    portfolioFileName: "Stefanie_Agahari_Portofolio_2025.pdf",
    coverLetterFileName: "Stefanie_Agahari_Motivation_Letter.pdf",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "18 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Undangan Wawancara",
        date: "25 Oktober 2025",
        subtitle: "(Detail di email)",
        isActive: true,
        isCompleted: false,
      ),
    ],
  ),

  // Ditolak
  ApplicationModel(
    id: "app_8",
    userId: "user_001",
    jobId: "1",
    jobTitle: "Front-end Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 15 Oktober 2025",
    status: "Ditolak",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Tidak Lolos", date: "20 Okt 2025", isActive: true),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),
  ApplicationModel(
    id: "app_9",
    userId: "user_001",
    jobId: "2",
    jobTitle: "Social Media Freelance",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Diterima",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Wawancara", date: "15 Okt 2025", isCompleted: true),
      TimelineEvent(
        title: "Offering Letter",
        date: "18 Okt 2025",
        isCompleted: true,
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),

  // Ditinjau
  ApplicationModel(
    id: "app_10",
    userId: "user_001",
    jobId: "4",
    jobTitle: "Data Analyst",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Ditinjau",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "13 Okt 2025",
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_Data_CV.pdf",
  ),

  // Wawancara
  ApplicationModel(
    id: "app_11",
    userId: "user_001",
    jobId: "3",
    jobTitle: "Website Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Wawancara",
    cvFileName: "Stefanie_Agahari_CV_2025.pdf",
    portfolioFileName: "Stefanie_Agahari_Portofolio_2025.pdf",
    coverLetterFileName: "Stefanie_Agahari_Motivation_Letter.pdf",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "18 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Undangan Wawancara",
        date: "25 Oktober 2025",
        subtitle: "(Detail di email)",
        isActive: true,
        isCompleted: false,
      ),
    ],
  ),

  // Ditolak
  ApplicationModel(
    id: "app_12",
    userId: "user_001",
    jobId: "1",
    jobTitle: "Front-end Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 15 Oktober 2025",
    status: "Ditolak",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Tidak Lolos", date: "20 Okt 2025", isActive: true),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),
  ApplicationModel(
    id: "app_13",
    userId: "user_001",
    jobId: "2",
    jobTitle: "Social Media Freelance",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Diterima",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Wawancara", date: "15 Okt 2025", isCompleted: true),
      TimelineEvent(
        title: "Offering Letter",
        date: "18 Okt 2025",
        isCompleted: true,
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),

  // Ditinjau
  ApplicationModel(
    id: "app_14",
    userId: "user_001",
    jobId: "4",
    jobTitle: "Data Analyst",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Ditinjau",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "12 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "13 Okt 2025",
        isActive: true,
      ),
    ],
    cvFileName: "Stefanie_Data_CV.pdf",
  ),

  ApplicationModel(
    id: "app_15",
    userId: "user_001",
    jobId: "3",
    jobTitle: "Website Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 12 Oktober 2025",
    status: "Wawancara",
    cvFileName: "Stefanie_Agahari_CV_2025.pdf",
    portfolioFileName: "Stefanie_Agahari_Portofolio_2025.pdf",
    coverLetterFileName: "Stefanie_Agahari_Motivation_Letter.pdf",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Sedang Ditinjau",
        date: "18 Oktober 2025",
        isCompleted: true,
      ),
      TimelineEvent(
        title: "Undangan Wawancara",
        date: "25 Oktober 2025",
        subtitle: "(Detail di email)",
        isActive: true, 
        isCompleted: false,
      ),
    ],
  ),

  // Ditolak
  ApplicationModel(
    id: "app_16",
    userId: "user_001",
    jobId: "1",
    jobTitle: "Front-end Developer",
    companyName: "Metrodata",
    companyLogoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Metrodata_Electronics_logo.svg/1200px-Metrodata_Electronics_logo.svg.png",
    location: "Jakarta, Indonesia",
    type: "Freelance (Hybrid)",
    appliedDate: "Dilamar 15 Oktober 2025",
    status: "Ditolak",
    timeline: [
      TimelineEvent(
        title: "Aplikasi Dikirim",
        date: "15 Okt 2025",
        isCompleted: true,
      ),
      TimelineEvent(title: "Tidak Lolos", date: "20 Okt 2025", isActive: true),
    ],
    cvFileName: "Stefanie_CV.pdf",
  ),
];

List<FavoriteModel> dummyFavorites = [
  // Contoh: User Stefanie (user_001) menyukai Job 1 (Front-end) -> Status Aktif
  FavoriteModel(
    id: "fav_1",
    userId: "user_001",
    jobId: "1",
    isFavorite: true, 
  ),
  
  // Contoh: User Stefanie menyukai Job 5 (UI/UX) -> Status Aktif
  FavoriteModel(
    id: "fav_2",
    userId: "user_001",
    jobId: "5",
    isFavorite: true,
  ),

  // Contoh: User Stefanie DULU menyukai Job 2 (Marketing), tapi sudah di-unlike -> Status False
  // Data ini tetap ada di database, tapi tidak akan muncul di list "Saved Jobs"
  FavoriteModel(
    id: "fav_3",
    userId: "user_001",
    jobId: "2",
    isFavorite: false,
  ),

  // Contoh: User Lain (user_002) menyukai Job 1 -> Tidak boleh muncul di akun Stefanie
  FavoriteModel(
    id: "fav_4",
    userId: "user_002",
    jobId: "1",
    isFavorite: true,
  ),
];