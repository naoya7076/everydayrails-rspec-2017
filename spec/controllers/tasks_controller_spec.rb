require 'rails_helper'

# TODO: 5章の演習問題やる
RSpec.describe TasksController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner: @user)
    @task = @project.tasks.create!(name: "Test task")
  end

  describe "#show" do
    it "responds with Json formatted output" do
      sign_in @user
      get :show, format: :json, # json形式であることを指定する
        params: {project_id: @project.id, id: @task.id}
      expect(response.content_type).to eq "application/json"
    end
  end

  describe "#create" do
    it "responds with Json formatted output" do
      new_task = { name: "New test task"}
      sign_in @user
      post :create, format: :json,
        params: { project_id: @project.id, task: new_task}
      expect(response.content_type).to eq "application/json"
    end

    # 新しいタスクをプロジェクトに追加すること
    it "adds new task to the project" do
      new_task = { name: "New test task"}
      sign_in @user
      expect{
        post :create, format: :json,
        params: {project_id: @project.id, task: new_task}
      }.to change(@project.tasks, :count).by(1)
    end

    # 認証を要求すること
    it "requires authentication" do
      new_task = { name: "New test task"}
      # ここではログインしない
      expect{
        post :create, format: :json,
        params: {project_id: @project.id, task: new_task}
      }.to_not change(@project.tasks, :count)
      expect(response).to_not be_success  
    end
  end
end
