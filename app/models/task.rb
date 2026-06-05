class Task
  attr_accessor :id, :title, :description, :status, :priority, :due_date

  def initialize(id:, title:, description:, status:, priority:, due_date:)
    @id = id
    @title = title
    @description = description
    @status = status
    @priority = priority
    @due_date = due_date
  end

  def self.all
    [
      new(id: 1, title: "Design landing page", description: "Create wireframes and mockups for the new marketing site.", status: "in_progress", priority: "high", due_date: "2025-06-10"),
      new(id: 2, title: "Write API documentation", description: "Document all REST endpoints with examples.", status: "todo", priority: "medium", due_date: "2025-06-15"),
      new(id: 3, title: "Fix login bug", description: "Users get logged out randomly on mobile browsers.", status: "todo", priority: "high", due_date: "2025-06-07"),
      new(id: 4, title: "Setup CI/CD pipeline", description: "Automate testing and deployment using GitHub Actions.", status: "done", priority: "medium", due_date: "2025-05-30"),
      new(id: 5, title: "Code review - payments", description: "Review pull request for the new Stripe integration.", status: "done", priority: "low", due_date: "2025-05-28"),
      new(id: 6, title: "Optimize database queries", description: "Profile and optimize slow N+1 queries in the dashboard.", status: "in_progress", priority: "high", due_date: "2025-06-12"),
    ]
  end
end