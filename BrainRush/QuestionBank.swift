//
//  QuestionBank.swift
//  BrainRush
//

import Foundation

struct QuestionBank {
    
    static let topics: [Topic] = [
        Topic(
            id: "comp_basics",
            title: "Computer Basics",
            summary: "Fundamentals of Computers",
            iconSystemName: "laptopcomputer",
            details: "Test your knowledge about computer fundamentals, hardware, software, and other basic concepts."
        ),
        Topic(
            id: "programming",
            title: "Programming",
            summary: "C, C++, Java basics",
            iconSystemName: "chevron.left.forwardslash.chevron.right",
            details: "Explore core programming paradigms, syntax, variables, data structures, and algorithmic logic."
        ),
        Topic(
            id: "dbms",
            title: "DBMS",
            summary: "Database concepts and SQL",
            iconSystemName: "cylinder.split.1x2",
            details: "Review relational models, SQL queries, normalization, keys, transactions, and index management."
        ),
        Topic(
            id: "networking",
            title: "Networking",
            summary: "Computer Networks basics",
            iconSystemName: "network",
            details: "Learn about OSI layers, TCP/IP, IP addressing, routing, protocols, and network hardware."
        ),
        Topic(
            id: "os",
            title: "Operating System",
            summary: "OS concepts and scheduling",
            iconSystemName: "cpu",
            details: "Deep dive into CPU scheduling, processes, threads, virtual memory, paging, and deadlocks."
        )
    ]
    
    static let allQuestions: [Question] = [
        // MARK: - Computer Basics (Easy, Medium, Hard, Legend)
        Question(
            topicId: "comp_basics",
            text: "Which of the following is considered the brain of the computer?",
            options: ["RAM", "Central Processing Unit (CPU)", "Hard Disk", "Power Supply"],
            correctOptionIndex: 1,
            difficulty: .rookie
        ),
        Question(
            topicId: "comp_basics",
            text: "Which type of memory is volatile and loses data when powered off?",
            options: ["ROM", "Flash Memory", "RAM", "Hard Drive"],
            correctOptionIndex: 2,
            difficulty: .rookie
        ),
        Question(
            topicId: "comp_basics",
            text: "1 Gigabyte (GB) is equal to how many Megabytes (MB)?",
            options: ["100 MB", "1000 MB", "1024 MB", "512 MB"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "comp_basics",
            text: "What does BIOS stand for?",
            options: [
                "Basic Input Output System",
                "Binary Integrated Operating Software",
                "Base Internal Optical Sensor",
                "Backup Interface Online System"
            ],
            correctOptionIndex: 0,
            difficulty: .challenger
        ),
        Question(
            topicId: "comp_basics",
            text: "Which cache level is typically the fastest and closest to the CPU core?",
            options: ["L3 Cache", "L2 Cache", "L1 Cache", "Disk Cache"],
            correctOptionIndex: 2,
            difficulty: .pro
        ),
        Question(
            topicId: "comp_basics",
            text: "What bus connects the CPU directly to high-speed memory in legacy computer architectures?",
            options: ["Southbridge", "Northbridge (Front-Side Bus)", "PCIe Bus", "SATA Bus"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "comp_basics",
            text: "Which pipelining hazard occurs when instructions depend on the result of a previous uncompleted instruction?",
            options: ["Structural hazard", "Data hazard", "Control hazard", "Branch hazard"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        Question(
            topicId: "comp_basics",
            text: "In computer architecture, what principle justifies the effective use of cache memory?",
            options: ["Amdahl's Law", "Locality of Reference", "Moore's Law", "Little's Law"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        
        // MARK: - Programming
        Question(
            topicId: "programming",
            text: "Which symbol is used for single-line comments in C, C++, and Java?",
            options: ["#", "//", "<!--", "--"],
            correctOptionIndex: 1,
            difficulty: .rookie
        ),
        Question(
            topicId: "programming",
            text: "What is the typical output of 5 / 2 in integer division in C/Java?",
            options: ["2.5", "2", "3", "Error"],
            correctOptionIndex: 1,
            difficulty: .rookie
        ),
        Question(
            topicId: "programming",
            text: "What is the time complexity to access an element by index in an array?",
            options: ["O(1)", "O(n)", "O(log n)", "O(n^2)"],
            correctOptionIndex: 0,
            difficulty: .challenger
        ),
        Question(
            topicId: "programming",
            text: "Which keyword is used in Java to inherit a class?",
            options: ["implements", "inherits", "extends", "super"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "programming",
            text: "In C++, what is a class called that contains at least one pure virtual function?",
            options: ["Concrete class", "Abstract class", "Interface class", "Static class"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "programming",
            text: "Which data structure is primarily used by the runtime engine for function call execution?",
            options: ["Queue", "Call Stack", "Heap", "Binary Tree"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "programming",
            text: "In modern Swift and memory management, what problem does a 'weak' reference prevent?",
            options: ["Dangling pointer", "Retain cycle (Memory leak)", "Stack overflow", "Segmentation fault"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        Question(
            topicId: "programming",
            text: "What is the amortized time complexity of inserting an element into a dynamic array?",
            options: ["O(1)", "O(n)", "O(log n)", "O(n log n)"],
            correctOptionIndex: 0,
            difficulty: .legend
        ),
        
        // MARK: - DBMS
        Question(
            topicId: "dbms",
            text: "What does SQL stand for?",
            options: [
                "Structured Query Language",
                "Simple Quick Language",
                "Sequential Query Logic",
                "System Query Listing"
            ],
            correctOptionIndex: 0,
            difficulty: .rookie
        ),
        Question(
            topicId: "dbms",
            text: "Which SQL command is used to retrieve data from a table?",
            options: ["FETCH", "GET", "SELECT", "PULL"],
            correctOptionIndex: 2,
            difficulty: .rookie
        ),
        Question(
            topicId: "dbms",
            text: "Which constraint uniquely identifies each record in a database table?",
            options: ["FOREIGN KEY", "UNIQUE", "PRIMARY KEY", "CHECK"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "dbms",
            text: "Which SQL clause is used to filter records after an aggregate GROUP BY operation?",
            options: ["WHERE", "ORDER BY", "HAVING", "LIMIT"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "dbms",
            text: "A table is in 2NF if it is in 1NF and contains no:",
            options: [
                "Transitive dependencies",
                "Partial dependencies on a composite key",
                "Multi-valued dependencies",
                "Foreign keys"
            ],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "dbms",
            text: "In transaction management, what does the 'I' in ACID stand for?",
            options: ["Integrity", "Isolation", "Inheritance", "Indexation"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "dbms",
            text: "Which index structure is standard for disk-based relational database indexing?",
            options: ["Red-Black Tree", "B+ Tree", "Hash Map", "Skip List"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        Question(
            topicId: "dbms",
            text: "In database concurrency, which phenomenon occurs when a transaction reads uncommitted changes of another?",
            options: ["Non-repeatable read", "Phantom read", "Dirty read", "Lost update"],
            correctOptionIndex: 2,
            difficulty: .legend
        ),
        
        // MARK: - Networking
        Question(
            topicId: "networking",
            text: "What is the standard port number for HTTP web traffic?",
            options: ["21", "22", "80", "443"],
            correctOptionIndex: 2,
            difficulty: .rookie
        ),
        Question(
            topicId: "networking",
            text: "Which protocol resolves a human-readable domain name (like google.com) to an IP address?",
            options: ["FTP", "DHCP", "DNS", "SMTP"],
            correctOptionIndex: 2,
            difficulty: .rookie
        ),
        Question(
            topicId: "networking",
            text: "How many layers are in the theoretical OSI reference model?",
            options: ["4", "5", "7", "8"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "networking",
            text: "Which protocol is connection-oriented and guarantees reliable, ordered packet delivery?",
            options: ["UDP", "IP", "TCP", "ICMP"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "networking",
            text: "Which layer of the OSI model does a network router primarily operate at?",
            options: ["Data Link Layer (Layer 2)", "Network Layer (Layer 3)", "Transport Layer (Layer 4)", "Physical Layer (Layer 1)"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "networking",
            text: "What protocol does the 'ping' utility rely on to test network reachability?",
            options: ["IGMP", "ICMP", "ARP", "BGP"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "networking",
            text: "In TCP congestion control, what algorithm triggers after 3 duplicate ACKs are received?",
            options: ["Slow Start", "Fast Retransmit & Fast Recovery", "Nagle's Algorithm", "Sliding Window Shift"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        Question(
            topicId: "networking",
            text: "What is the default subnet mask for a Class B IPv4 network?",
            options: ["255.0.0.0", "255.255.0.0", "255.255.255.0", "255.255.255.255"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        
        // MARK: - Operating System
        Question(
            topicId: "os",
            text: "Which of the following is an Operating System?",
            options: ["Google Chrome", "Windows", "MS Word", "MySQL"],
            correctOptionIndex: 1,
            difficulty: .rookie
        ),
        Question(
            topicId: "os",
            text: "What is a program in execution called?",
            options: ["Thread", "Process", "Instruction", "Subroutine"],
            correctOptionIndex: 1,
            difficulty: .rookie
        ),
        Question(
            topicId: "os",
            text: "Which scheduling algorithm gives each process a fixed slice of CPU time (time quantum)?",
            options: ["First-Come, First-Served", "Shortest Job First", "Round Robin", "Priority Scheduling"],
            correctOptionIndex: 2,
            difficulty: .challenger
        ),
        Question(
            topicId: "os",
            text: "What condition occurs when two or more processes are unable to proceed because each is waiting for the other?",
            options: ["Starvation", "Deadlock", "Thrashing", "Race condition"],
            correctOptionIndex: 1,
            difficulty: .challenger
        ),
        Question(
            topicId: "os",
            text: "Which memory management scheme allows the physical address space of a process to be non-contiguous?",
            options: ["Paging", "Overlaying", "Monoprogramming", "Fixed Partitioning"],
            correctOptionIndex: 0,
            difficulty: .pro
        ),
        Question(
            topicId: "os",
            text: "What is the phenomenon called when the CPU spends more time swapping pages than executing instructions?",
            options: ["Paging Spike", "Thrashing", "Deadlock", "Swapping Drift"],
            correctOptionIndex: 1,
            difficulty: .pro
        ),
        Question(
            topicId: "os",
            text: "Which classic deadlock avoidance algorithm tests for safe states using allocation and max need matrices?",
            options: ["Peterson's Algorithm", "Banker's Algorithm", "Bakery Algorithm", "Dekker's Algorithm"],
            correctOptionIndex: 1,
            difficulty: .legend
        ),
        Question(
            topicId: "os",
            text: "What hardware component translates virtual memory addresses to physical RAM addresses?",
            options: ["ALU", "TLB / MMU (Memory Management Unit)", "DMA Controller", "Bus Interface Unit"],
            correctOptionIndex: 1,
            difficulty: .legend
        )
    ]
}
