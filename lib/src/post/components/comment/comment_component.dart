import 'package:angular/angular.dart';
import 'package:angular_blog/models/comment.dart';


@Component(
  selector: 'app-comment',
  templateUrl: 'comment_component.html',
  directives: [Input,],
  pipes: [DatePipe,]
)
class  CommentComponent {
  @Input()
  Comment comment;
}