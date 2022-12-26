enum Status { loading, success, error }

class Result<T> {
  Status status;
  T? data;
  String? message;
  Result.loading() : status = Status.loading;
  Result.success(this.data) : status = Status.success;
  Result.error(this.message) : status = Status.error;
}
