import 'package:test/test.dart';
import 'package:build_verify/build_verify.dart';

@Tags(['presubmit-only'])
void main(){
  test('ensure_build', expectBuildClean);
}