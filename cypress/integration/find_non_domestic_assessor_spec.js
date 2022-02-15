describe('Find a non-domestic assessor (English', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`get_service_en_${Cypress.env('API_STAGE') || 'production'}`))
    cy.contains('Start now').click()
    cy.get('#label-non-domestic').click()
    cy.contains('Continue').click()
    cy.get('input[name=postcode]').type('SW1A 2AA')
    cy.contains('button', 'Find').click()
  })

  it('shows assessor search results', () => {
    cy.get('body').should('contain', 'assessors in order of distance from SW1A 2AA')
  })
})

describe('Find a non-domestic assessor (Welsh)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`get_service_cy_${Cypress.env('API_STAGE') || 'production'}`))
    cy.contains('Dechrau nawr').click()
    cy.get('#label-non-domestic').click()
    cy.contains('Parhau').click()
    cy.get('input[name=postcode]').type('SW1A 2AA')
    cy.contains('button', 'Chwiliwch').click()
  })

  it('shows assessor search results', () => {
    cy.get('body').should('contain', 'aseswyr yn nhrefn eu pellter o SW1A 2AA')
  })
})
