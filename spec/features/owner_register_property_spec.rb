require 'rails_helper'

feature 'Owner register property' do
  scenario 'successfully' do

    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    click_on 'Registrar imóvel'

    fill_in 'Título', with: 'Casa charmosa em Ubatuba'
    fill_in 'Tipo da propriedade', with: 'Casa'
    fill_in 'Descrição', with: 'Casa nova, com quartos climatizados e wi-fi'
    fill_in 'Localização', with: 'Ubatuba'
    fill_in 'Finalidade da locação', with: 'Férias'
    check 'Acessibilidade'
    check 'Aceita animais'
    uncheck 'Aceita fumantes'
    fill_in 'Total de quartos', with: '2'
    fill_in 'Número máximo de hóspedes', with: '8'
    fill_in 'Número minimo de dias para locação', with: '5'
    fill_in 'Número máximo de dias para locação', with: '30'
    fill_in 'Valor da diária', with: '300.00'
    click_on 'Salvar'

    expect(page).to have_css('h1', text: 'Casa charmosa em Ubatuba')
    expect(page).to have_css('h3', text: 'Casa')
    expect(page).to have_css('p', text: 'Ubatuba')
    expect(page).to have_css('p', text: 'Casa nova, com quartos climatizados e wi-fi')
    expect(page).to have_css('p', text: "Finalidade da locação: Férias")
    expect(page).to have_css('p', text: "Acessibilidade: Sim")
    expect(page).to have_css('p', text: "Aceita animais: Sim")
    expect(page).to have_css('p', text: "Aceita fumantes: Não")
    expect(page).to have_css('p', text: "2 quartos")
    expect(page).to have_css('p', text: "Número máximo de hóspedes: 8")
    expect(page).to have_css('p', text: "Locação de 5 a 30 dias")
    expect(page).to have_css('p', text: "Valor da diária R$ 300,00")
  end

  scenario 'and dont fill all inputs' do

    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    click_on 'Registrar imóvel'

    click_on 'Salvar'

    expect(page).to have_css('h3', text: "Todos os campos devem ser preenchidos")

  end

  scenario 'and dont fill title' do

    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')
          
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    click_on 'Registrar imóvel'

    fill_in 'Tipo da propriedade', with: 'Casa'
    fill_in 'Descrição', with: 'Casa nova, com quartos climatizados e wi-fi'
    fill_in 'Localização', with: 'Ubatuba'
    fill_in 'Finalidade da locação', with: 'Férias'
    check 'Acessibilidade'
    check 'Aceita animais'
    uncheck 'Aceita fumantes'
    fill_in 'Total de quartos', with: '2'
    fill_in 'Número máximo de hóspedes', with: '8'
    fill_in 'Número minimo de dias para locação', with: '5'
    fill_in 'Número máximo de dias para locação', with: '30'
    fill_in 'Valor da diária', with: '300.00'
    click_on 'Salvar'

    expect(page).to have_css('h4', text: 'Você deve preencher o título.')
  end
end
