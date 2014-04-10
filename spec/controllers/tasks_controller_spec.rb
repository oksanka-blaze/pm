require 'spec_helper'

describe TasksController do

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project, owner: user) }
    subject { FactoryGirl.create(:task, project: project) }
        
    before do
      sign_in user
    end

    describe "GET #index" do
      it "render :index view" do
        get :index, project_id: project.id
        expect(response).to render_template :index
      end

      it "assigns the requested project to subject" do
        get :index, project_id: project.id
        expect(assigns(:tasks)).to eq([subject])
      end
    end

    describe "GET #new" do
      it "assigns the requested task to new task" do
        get :new, project_id: project.id
        expect(assigns(:task)).to be_new_record 
      end
      
      it "renders the :new view" do
        get :new, project_id: project.id
        expect(response).to render_template :new
      end
      
      it "assigns project from params" do
        get :new, project_id: project.id
        expect(assigns(:project)).to eq(project)
      end
      
    end

    describe "PATCH #assign" do
      it "assigns the task assignee to current_user" do
        patch :assign, id: subject.id
        expect(subject.reload.assignee).to eq(user) 
      end
      
      it "redirects to tasks" do
        patch :assign, id: subject.id
        expect(response).to redirect_to project_tasks_path(subject.project)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{
            post :create, project_id: project.id, task: FactoryGirl.attributes_for(:task)
          }.to change(Task, :count).by(1)
        end
      
        it "rendirects to index path" do
          post :create, project_id: project.id, task: FactoryGirl.attributes_for(:task)
          expect(response).to redirect_to project_tasks_path(project.id)
        end
      end
      
      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            post :create, project_id: project.id, task: FactoryGirl.attributes_for(:task, name: nil)
          }.to_not change(Task, :count)
        end
      
        it "render new view" do
          post :create, project_id: project.id, task: FactoryGirl.attributes_for(:task, name: nil)
          expect(response).to render_template :new
        end
      end
    end
  end
end
