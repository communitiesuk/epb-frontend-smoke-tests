describe('Find a Domestic Assessor (English)', () => {
  it('shows assessor search results', () => {
    cy.visit(Cypress.env(`get_service_en_${process.env.API_STAGE || 'integration'}`))
    cy.contains('Start now').click()
    cy.get('#label-domestic').click()
    cy.contains('Continue').click()
    cy.get('#label-domesticRdSap').click()
    cy.contains('Continue').click()
    cy.contains('find an assessor by name').click()
    cy.get('input[name=name]').type('Andrew Parkin')
    cy.contains('Search').click()
    cy.get('body').should('contain', 'results for the name Andrew Parkin')
  })
})

describe('Find a Domestic Assessor (Welsh)', () => {
  it('shows assessor search results', () => {
    cy.visit(Cypress.env(`get_service_cy_${process.env.API_STAGE || 'integration'}`))
    cy.contains('Dechrau nawr').click()
    cy.get('#label-domestic').click()
    cy.contains('Parhau').click()
    cy.get('#label-domesticRdSap').click()
    cy.contains('Parhau').click()
    cy.contains('chwilio am asesydd yn ôl enw').click()
    cy.get('input[name=name]').type('Andrew Parkin')
    cy.contains('button', 'Chwiliwch').click()
    cy.get('body').should('contain', 'canlyniadau ar gyfer yr enw Andrew Parkin')
  })
})
