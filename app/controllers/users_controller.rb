class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun'),

      User.new(
        id: 3,
        name: 'Damir',
        username: 'quietpochatjok',
        avatar_url: 'https://lurkmore.so/images/thumb/1/19/'\
        'Blobfish_1.jpg/250px-Blobfish_1.jpg'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Dam4ir',
      username: 'quietpochatok',
      avatar_url: 'https://lurkmore.so/images/thumb/1/19/Blobfish_1.jpg/250px-Blobfish_1.jpg'
      )
    @questions = [
      Question.new(text:'Скажи от 1 до 10 насколько ты сильно "любишь" CSS?',
        created_at: Date.parse('27.03.2020')),
      Question.new(text: 'Ведь такой "КАЕФ" сидеть и центровать ОДНУ кнопку/блок 3-4 часа подряд))00)?',
        created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
