const stage = Cypress.env('API_STAGE') || 'production'
const isCrossOrigin = (Cypress.env(`get_service_en_${stage}`) !== Cypress.env(`get_domain_${stage}`))

describe('Find EPC by postcode', () => {
    context('with a postcode for which certificates exist', () => {
        beforeEach(() => {
            cy.visit(Cypress.env(`find_service_en_${Cypress.env('API_STAGE') || 'production'}`))
            cy.contains('Start now').click()
            if (isCrossOrigin) {
                cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                    cy.get('#label-domestic').click()
                    cy.contains('Continue').click()
                    cy.get('input[name=postcode]').type('HP17 0UZ')
                    cy.contains('button', 'Find').click()
                })
            } else {
                cy.get('#label-domestic').click()
                cy.contains('Continue').click()
                cy.get('input[name=postcode]').type('HP17 0UZ')
                cy.contains('button', 'Find').click()
            }
        })

        it('shows existence of those certificates on the search results page', () => {
            if (isCrossOrigin) {
                cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                    cy.get('body').should(body => {
                        const bodyInner = body.text()
                        expect(bodyInner).to.match(/EPCs? for HP17 0UZ/)
                    })
                })
            } else {
                cy.get('body').should(body => {
                    const bodyInner = body.text()
                    expect(bodyInner).to.match(/EPCs? for HP17 0UZ/)
                })
            }
        })

        context('when selecting a known certificate from the results list', () => {
            beforeEach(() => {
                if (isCrossOrigin) {
                    cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                        cy.contains('3 Gardeners Cottages,').click()
                    })
                } else {
                    cy.contains('3 Gardeners Cottages,').click()
                }
            })

            it('shows the certificate with the expected header', () => {
                if (isCrossOrigin) {
                    cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                        cy.get('body').should('contain', 'Energy performance certificate (EPC)')
                    })
                } else {
                    cy.get('body').should('contain', 'Energy performance certificate (EPC)')
                }
            })
        })
    })
})

describe('Find EPC by postcode in Welsh', () => {
    context('with a postcode for which certificates exist', () => {
        beforeEach(() => {
            cy.visit(Cypress.env(`find_service_cy_${Cypress.env('API_STAGE') || 'production'}`))
            cy.contains('Dechrau nawr').click()
            if (isCrossOrigin) {
                cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                    cy.get('#label-domestic').click()
                    cy.contains('Parhau').click()
                    cy.get('input[name=postcode]').type('HP17 0UZ')
                    cy.contains('button', 'Chwiliwch').click()
                })
            } else {
                cy.get('#label-domestic').click()
                cy.contains('Parhau').click()
                cy.get('input[name=postcode]').type('HP17 0UZ')
                cy.contains('button', 'Chwiliwch').click()
            }
        })

        it('shows existence of those certificates on the search results page', () => {
            if (isCrossOrigin) {
                cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                    cy.get('body').should(body => {
                        const bodyInner = body.text()
                        expect(bodyInner).to.match(/EPCs? ar gyfer HP17 0UZ/)
                    })
                })
            } else {
                cy.get('body').should(body => {
                    const bodyInner = body.text()
                    expect(bodyInner).to.match(/EPCs? ar gyfer HP17 0UZ/)
                })
            }
        })

        context('when selecting a known certificate from the results list', () => {
            beforeEach(() => {
                if (isCrossOrigin) {
                    cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                        cy.contains('3 Gardeners Cottages,').click()
                    })
                } else {
                    cy.contains('3 Gardeners Cottages,').click()
                }
            })

            it('shows the certificate with the expected header', () => {
                if (isCrossOrigin) {
                    cy.origin(Cypress.env(`find_domain_${stage}`), () => {
                        cy.get('body').should('contain', 'Tystysgrif perfformiad ynni (EPC)')
                    })
                } else {
                    cy.get('body').should('contain', 'Tystysgrif perfformiad ynni (EPC)')
                }
            })
        })
    })
})
