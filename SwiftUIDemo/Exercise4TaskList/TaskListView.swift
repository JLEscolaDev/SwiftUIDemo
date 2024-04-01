//
//  TaskList.swift
//  SwiftUIDemo
//
//  Created by Jose Luis Escolá García on 28/3/24.
//

import SwiftUI

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
}

import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = [
        Task(name: "Sample Task 1", isCompleted: false),
        Task(name: "Sample Task 2", isCompleted: false)
    ]
    @State private var newTaskName: String = ""
    @State private var showCompletedTasks: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                // Task manipulation buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Button(action: completeAllTasks) {
                            Text("Complete all")
                        }
                        .buttonStyle(TaskButtonStyle())

                        Button(action: {
                            self.showCompletedTasks = true
                        }) {
                            Text("Show done tasks")
                        }
                        .buttonStyle(TaskButtonStyle())

                        Button(action: {
                            self.showCompletedTasks = false
                        }) {
                            Text("Hide done tasks")
                        }
                        .buttonStyle(TaskButtonStyle())
                    }
                    .padding(.horizontal)
                }
                
                // Progress Bar
                ProgressBarView(value: progressValue)

                Divider()

                // New task input field
                HStack {
                    TextField("Set your new task here", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addNewTask) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                    .disabled(newTaskName.isEmpty)
                }.padding()

                // Tasks list
                List {
                    ForEach(filteredTasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    markTaskAsCompleted(taskId: task.id)
                                }
                            Text(task.name)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationBarTitle("Task Table View Controller")
        }
    }

    /// Computed property to calculate the progress value
    private var progressValue: Float {
        let totalTasks = tasks.count
        let completedTasks = tasks.filter { $0.isCompleted }.count
        return totalTasks == 0 ? 0 : Float(completedTasks) / Float(totalTasks)
    }

    /// Helper computed property to filter tasks based on completion status
    private var filteredTasks: [Task] {
        showCompletedTasks ? tasks : tasks.filter { !$0.isCompleted }
    }

    /// Function to mark all tasks as completed
    private func completeAllTasks() {
        tasks.indices.forEach { tasks[$0].isCompleted = true }
    }

    /// Function to add a new task
    private func addNewTask() {
        let newTask = Task(name: newTaskName, isCompleted: false)
        tasks.append(newTask)
        newTaskName = ""
    }

    /// Function to mark a specific task as completed
    private func markTaskAsCompleted(taskId: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == taskId }) {
            withAnimation(.easeInOut) {
                tasks[index].isCompleted.toggle()
            }
        }
    }

    /// Function to delete a task
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

/// A view that displays the progress as a bar
struct ProgressBarView: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: 4)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 4)
                    .foregroundColor(Color(UIColor.green))
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        }
        .frame(height: 4)
    }
}


/// Custom button style for task buttons
struct TaskButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

#Preview {
    TaskListView()
}
