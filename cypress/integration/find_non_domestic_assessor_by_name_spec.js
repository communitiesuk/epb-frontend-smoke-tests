describe('Find a non-domestic assessor (English)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`get_service_en_${process.env.API_STAGE || 'integration'}`))
    cy.contains('Start now').click()
    cy.get('#label-non-domestic').click()
    cy.contains('Continue').click()
  })

  context('when searching by name', () => {
    beforeEach(() => {
      cy.contains('find an assessor by name').click()
      cy.get('input[name=name]').type('Andrew Parkin')
      cy.contains('button', 'Search').click()
    })

    it('shows assessor search results', () => {
      cy.get('body').should('contain', 'results for the name Andrew Parkin')
    })
  })
})

describe('Find a non-domestic assessor (Welsh)', () => {
  beforeEach(() => {
    cy.visit(Cypress.env(`get_service_cy_${process.env.API_STAGE || 'integration'}`))
    cy.contains('Dechrau nawr').click()
    cy.get('#label-non-domestic').click()
    cy.contains('Parhau').click()
  })

  context('when searching for an assessor by name', () => {
    beforeEach(() => {
      cy.contains('chwilio am asesydd yn ôl enw').click()
      cy.get('input[name=name]').type('Andrew Parkin')
      cy.contains('button', 'Chwiliwch').click()
    })

    it('shows assessor search results', () => {
      cy.get('body').should('contain', 'canlyniadau ar gyfer yr enw Andrew Parkin')
    })
  })
})
