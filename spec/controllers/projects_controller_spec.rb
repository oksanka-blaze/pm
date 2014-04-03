require 'spec_helper'

describe ProjectsController do

  context "when user not logged in" do
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:project, owner: user) }
        
    before do
      sign_in user
    end

    describe "GET #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns the requested project to subject" do
        get :index
        expect(assigns(:projects)).to eq([subject])
      end
    end

    describe "GET #show" do
      it "assigns the requested project to subject" do
        get :show, id: subject
        expect(assigns(:project)).to eq(subject)
      end

      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns the requested project to new project" do
        get :new
        expect(assigns(:project)).to be_new_record 
      end
      
      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{
            post :create, project: FactoryGirl.attributes_for(:project)
          }.to change(Project, :count).by(1)
        end
      
        it "rendirects to index path" do
          post :create, project: FactoryGirl.attributes_for(:project)
          expect(response).to redirect_to projects_path
        end
      end
      
      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            post :create, project: FactoryGirl.attributes_for(:invalid_project)
          }.to_not change(Project, :count)
        end
      
        it "render new view" do
          post :create, project: FactoryGirl.attributes_for(:invalid_project)
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{
            patch :update, id: subject, project: { name: 'new_project' }
          }.to change{ subject.reload.name }.to('new_project')
        end
      
        it "rendirects to index path" do
          patch :update, id: subject, project: { name: 'new_project' }
          expect(response).to redirect_to projects_path
        end
      end
      
      context "with not valid attributes" do
        it "not save object to db" do
          expect{
            patch :update, id: subject, project: FactoryGirl.attributes_for(:invalid_project)
          }.to_not change{ subject.name }
        end
      
        it "render edit view" do
          post :update, id: subject, project: FactoryGirl.attributes_for(:invalid_project)
          expect(response).to render_template :edit
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested project to subject" do
        get :edit, id: subject
        expect(assigns(:project)).to eq(subject)
      end
      
      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do
      before(:each) { @project = FactoryGirl.create :project, owner: user }

      it "deletes the project" do
        expect {
          delete :destroy, id: @project
        }.to change(Project, :count).by(-1)
      end

      it "redirects to projects#index" do
        delete :destroy, id: @project
        expect(response).to redirect_to projects_path
      end
    end
  end
end
