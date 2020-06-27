import { Component, OnInit } from '@angular/core';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css']
})
export class CommentComponent implements OnInit {

  title = 'Comment';
  comment: Comment[];
  newComment = new Comment();
  selected = null;
  editComment = null;

  // TODO what todo with campsiteRating to add to create new comment
  campsiteRating = null;

  constructor(
    private commentService: CommentService
  ) { }

  ngOnInit(): void {
  }
  onSubmit(comment){
    this.selected = comment;
  }

  reload() {
    console.log('reloading');

    this.commentService.index().subscribe(
      data => {
        this.comment = data;
        this.selected = null;
        this.editComment = null;
      },
      fail => {
        console.error('TodoListComponent.index(): error retrieving todos');
        console.error(fail);
      }
    );
  }

  loadComment(){
    this.commentService.index().subscribe(
      data => this.comment = data,
      err => console.error('Observer got an error: ' + err)
    );
  }

  // create comment
  create(){
    console.log(this.newComment);

    this.commentService.create(this.newComment).subscribe(
      data => {
        console.log('creation success');
        this.selected = null;
        this.loadComment();


      },
      err => {
        console.log('problem with creation');

      }
    );
  }

  // TODO campsite rating average


  // delete comment
  deleteComment(id: number) {
    this.commentService.delete(id).subscribe(
      reservation => {
        console.log('reservation delete was successful');
        this.reload();
      },
      fail => {
        console.error('TodoListComponent.index(): error retrieving todos');
        console.error(fail);
      }
    );
  }


  // update comment
  updateReservation(comment){
    this.commentService.update(comment).subscribe(
      reserve => {console.log('comment update success');
                  this.reload();
                  this.selected = null;
      },
      fail => {
        console.error('Comment component error');
      }
    );
  }

  updatePassRes(comment: Comment){
    console.log(comment);

    this.selected = comment;
    this.editComment = Object.assign({}, this.selected);
    // this.reload();
  }

}
