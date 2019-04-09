abstract class CounterVoteEvent {}

class Increment extends CounterVoteEvent {}
class Decrement extends CounterVoteEvent {}
class Reset extends CounterVoteEvent {}