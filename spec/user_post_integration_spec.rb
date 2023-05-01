# file: user_post_integration_spec.rb
require 'user_repository'
require 'post_repository'


RSpec.describe 'User and Post Integration' do
  let(:user_repo) { UserRepository.new }
  let(:post_repo) { PostRepository.new }


  it 'allows the user to create a post and find it' do
    # Create a new user
    user = User.new
    user.email = 'test@example.com'
    user.username = 'testuser'
    created_user = user_repo.create(user)

    # Ensure the created_user is not nil
    expect(created_user).not_to be_nil

    # Create a new post
    post = Post.new
    post.user_id = created_user.id
    post.title = 'Integration Test Post'
    post.content = 'This is an integration test post.'
    post.views = 0
    created_post = post_repo.create(post)

    # Ensure the created_post is not nil
    expect(created_post).not_to be_nil

    # Find the post
    found_post = post_repo.find(created_post.id)

    # Check if the found post is equal to the created post
    expect(found_post.id).to eq(created_post.id)
    expect(found_post.user_id).to eq(created_user.id)
    expect(found_post.title).to eq('Integration Test Post')
    expect(found_post.content).to eq('This is an integration test post.')
    expect(found_post.views).to eq(0)
  end
end
