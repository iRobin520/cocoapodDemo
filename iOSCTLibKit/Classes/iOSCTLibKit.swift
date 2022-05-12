import RxSwift

public class HelloWorld : NSObject {
    public func sayHi() -> String {
        return "Hello world! it works fine!"
    }
    
    public func getTodoTask() -> Observable<ToDoTask> {
        return ToDoService().getTodoTask()
    }
}
