class PostBroadcastJob < ApplicationJob
  queue_as :default

  def perform(post)
    ActionCable.server.broadcast 'post_channel', post: render_post(post)
  end

  private

  def render_post(post)
    PostsController.render partial: 'posts/post', locals: { post: post }
  end
end
