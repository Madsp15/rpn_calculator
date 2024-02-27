abstract class Command {
  apply(List<num> stack);
}

class Calculator {
  List<num> stack;

  Calculator(this.stack);

  push(num value) {
    stack.add(value);
  }

  execute(Command command) {
    if (stack.length >= 2) {
      command.apply(stack);
    }
  }
}

class Addition implements Command {
  @override
  void apply(List<num> stack) {
    stack.add(stack.removeLast() + stack.removeLast());
  }
}

class Subtraction implements Command {
  @override
  void apply(List<num> stack) {
    stack.add(stack.removeLast() - stack.removeLast());
  }
}

class Multiplication implements Command {
  @override
  void apply(List<num> stack) {
    stack.add(stack.removeLast() * stack.removeLast());
  }
}

class Division implements Command {
  @override
  void apply(List<num> stack) {
    stack.add(stack.removeLast() / stack.removeLast());
  }
}
